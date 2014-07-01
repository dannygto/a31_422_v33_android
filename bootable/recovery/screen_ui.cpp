/*
 * Copyright (C) 2011 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <errno.h>
#include <fcntl.h>
#include <linux/input.h>
#include <pthread.h>
#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#include "common.h"
#include "device.h"
#include "minui/minui.h"
#include "screen_ui.h"
#include "ui.h"

#define CHAR_WIDTH  BOARD_RECOVERY_CHAR_WIDTH
#define CHAR_HEIGHT BOARD_RECOVERY_CHAR_HEIGHT

// There's only (at most) one of these objects, and global callbacks
// (for pthread_create, and the input event system) need to find it,
// so use a global variable.
static ScreenRecoveryUI* self = NULL;

// Return the current time as a double (including fractions of a second).
static double now() {
    struct timeval tv;
    gettimeofday(&tv, NULL);
    return tv.tv_sec + tv.tv_usec / 1000000.0;
}

ScreenRecoveryUI::ScreenRecoveryUI() :
    currentIcon(NONE),
    currentTip(TIP_TITLE_NONE), // add by cjcheng
    installingFrame(0),
    rtl_locale(false),
    progressBarType(EMPTY),
    progressScopeStart(0),
    progressScopeSize(0),
    progress(0),
    pagesIdentical(false),
    text_cols(0),
    text_rows(0),
    text_col(0),
    text_row(0),
    text_top(0),
    show_text(false),
    show_text_ever(false),
    show_menu(false),
    menu_top(0),
    menu_items(0),
    menu_sel(0),
    menu_show_start(0),

    // These values are correct for the default image resources
    // provided with the android platform.  Devices which use
    // different resources should have a subclass of ScreenRecoveryUI
    // that overrides Init() to set these values appropriately and
    // then call the superclass Init().
    animation_fps(20),
    indeterminate_frames(6),
    installing_frames(7),
    install_overlay_offset_x(13),
    install_overlay_offset_y(190),
    overlay_offset_x(-1),
    overlay_offset_y(-1) {
    pthread_mutex_init(&updateMutex, NULL);
    self = this;
}

// Draw the given frame over the installation overlay animation.  The
// background is not cleared or draw with the base icon first; we
// assume that the frame already contains some other frame of the
// animation.  Does nothing if no overlay animation is defined.
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::draw_install_overlay_locked(int frame) {
    if (installationOverlay == NULL || overlay_offset_x < 0) return;
    gr_surface surface = installationOverlay[frame];
    int iconWidth = gr_get_width(surface);
    int iconHeight = gr_get_height(surface);
    gr_blit(surface, 0, 0, iconWidth, iconHeight,
            overlay_offset_x, overlay_offset_y);
}

// Clear the screen and draw the currently selected background icon (if any).
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::draw_background_locked(Icon icon)
{
    pagesIdentical = false;
    gr_color(0, 0, 0, 255);
    gr_fill(0, 0, gr_fb_width(), gr_fb_height());

    if (icon) {
        gr_surface surface = backgroundIcon[icon];
        gr_surface text_surface = backgroundText[icon];

        int iconWidth = gr_get_width(surface);
        int iconHeight = gr_get_height(surface);
        int textWidth = gr_get_width(text_surface);
        int textHeight = gr_get_height(text_surface);

        int iconX = (gr_fb_width() - iconWidth) / 2;
        int iconY = (gr_fb_height() - (iconHeight+textHeight+15)) / 2; // modify by cjcheng

        int textX = (gr_fb_width() - textWidth) / 2;
        int textY = ((gr_fb_height() - (iconHeight+textHeight+15)) / 2) + iconHeight + 15; // modify by cjcheng

        gr_blit(surface, 0, 0, iconWidth, iconHeight, iconX, iconY);
        if (icon == INSTALLING_UPDATE || icon == ERASING) {
            draw_install_overlay_locked(installingFrame);
        }

        gr_color(255, 255, 255, 255);
        gr_texticon(textX, textY, text_surface);
    }
}

/* add by cjcheng start... */
void ScreenRecoveryUI::draw_tip_title_locked(Tip tip)
{
    if (tip) {
        gr_surface surface = gTipTitle[tip];

        int tipWidth = gr_get_width(surface);
        int tipHeight = gr_get_height(surface);

        int tipX = (gr_fb_width() - tipWidth) / 2;
        int tipY = gr_fb_height() - tipHeight;

        gr_blit(surface, 0, 0, tipWidth, tipHeight, tipX, tipY);
    }
}

void ScreenRecoveryUI::draw_top_title_locked()
{
    gr_surface titleASurface = gTitleNotPowerOff;
    int titleAWidth = gr_get_width(titleASurface);
    int titleAHeight = gr_get_height(titleASurface);
    int titleAX = (gr_fb_width() - titleAWidth) / 2;
    int titleAY =  0;
    gr_blit(titleASurface, 0, 0, titleAWidth, titleAHeight, titleAX, titleAY);

    gr_surface titleBSurface = gTitleNotUnplug;
    int titleBWidth = gr_get_width(titleBSurface);
    int titleBHeight = gr_get_height(titleBSurface);
    int titleBX = (gr_fb_width() - titleBWidth) / 2;
    int titleBY = titleAY + titleAHeight;
    gr_blit(titleBSurface, 0, 0, titleBWidth, titleBHeight, titleBX, titleBY);
}
/* add by cjcheng end... */

// Draw the progress bar (if any) on the screen.  Does not flip pages.
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::draw_progress_locked()
{
    if (currentIcon == ERROR) return;

    if (currentIcon == INSTALLING_UPDATE || currentIcon == ERASING) {
        draw_install_overlay_locked(installingFrame);
    }

    if (progressBarType != EMPTY) {
        int iconHeight = gr_get_height(backgroundIcon[INSTALLING_UPDATE]);
        int width = gr_get_width(progressBarEmpty);
        int height = gr_get_height(progressBarEmpty);

        int dx = (gr_fb_width() - width)/2;
        int dy = (3*gr_fb_height() + iconHeight - 2*height)/4 - 20; // modify by cjcheng

        // Erase behind the progress bar (in case this was a progress-only update)
        gr_color(0, 0, 0, 255);
        gr_fill(dx, dy, width, height);

        if (progressBarType == DETERMINATE) {
            float p = progressScopeStart + progress * progressScopeSize;
            int pos = (int) (p * width);

            if (rtl_locale) {
                // Fill the progress bar from right to left.
                if (pos > 0) {
                    gr_blit(progressBarFill, width-pos, 0, pos, height, dx+width-pos, dy);
                }
                if (pos < width-1) {
                    gr_blit(progressBarEmpty, 0, 0, width-pos, height, dx, dy);
                }
            } else {
                // Fill the progress bar from left to right.
                if (pos > 0) {
                    gr_blit(progressBarFill, 0, 0, pos, height, dx, dy);
                }
                if (pos < width-1) {
                    gr_blit(progressBarEmpty, pos, 0, width-pos, height, dx+pos, dy);
                }
            }
        }

        if (progressBarType == INDETERMINATE) {
            static int frame = 0;
            gr_blit(progressBarIndeterminate[frame], 0, 0, width, height, dx, dy);
            // in RTL locales, we run the animation backwards, which
            // makes the spinner spin the other way.
            if (rtl_locale) {
                frame = (frame + indeterminate_frames - 1) % indeterminate_frames;
            } else {
                frame = (frame + 1) % indeterminate_frames;
            }
        }
    }
}

void ScreenRecoveryUI::draw_text_line(int row, const char* t) {
  if (t[0] != '\0') {
    gr_text(0, (row+1)*CHAR_HEIGHT-1, t);
  }
}

// Redraw everything on the screen.  Does not flip pages.
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::draw_screen_locked()
{
    draw_background_locked(currentIcon);
    draw_progress_locked();
    draw_top_title_locked(); // add by cjcheng
    draw_tip_title_locked(currentTip); // add by cjcheng

    if (show_text) {
        gr_color(0, 0, 0, 160);
        gr_fill(0, 0, gr_fb_width(), gr_fb_height());

        int i = 0;
		int j = 0;
		int row = 0;
        if (show_menu) {
            gr_color(64, 96, 255, 255);
            gr_fill(0, (menu_top+menu_sel-menu_show_start) * CHAR_HEIGHT,
                    gr_fb_width(), (menu_top+menu_sel-menu_show_start+1)*CHAR_HEIGHT+1);

         
            gr_color(255, 255, 255, 255);
            for (i = 0; i < menu_top; ++i) {
                draw_text_line(i, menu[i]);
				row++;
            }
			if (menu_items - menu_show_start + menu_top >= text_rows)
                j = text_rows- menu_top;
            else
                j = menu_items - menu_show_start;
			
            gr_color(64, 96, 255, 255);
            for (i = menu_show_start + menu_top; i < (menu_show_start + menu_top + j); ++i) {

					
                if (i == menu_top + menu_sel) {
                    gr_color(255, 255, 255, 255);
                    draw_text_line(i - menu_show_start, menu[i]);
                    gr_color(64, 96, 255, 255);
                } else {
                    draw_text_line(i - menu_show_start, menu[i]);
                }
				row++;
                if (row >= text_rows)
                    break;
            }
            gr_fill(0, row*CHAR_HEIGHT+CHAR_HEIGHT/2-1,
                    gr_fb_width(), row*CHAR_HEIGHT+CHAR_HEIGHT/2+1);
           // ++i;
        }

        gr_color(255, 255, 0, 255);

        for (; i < text_rows; ++i) {
            draw_text_line(i, text[(i+text_top) % text_rows]);
        }
    }
}

// Redraw everything on the screen and flip the screen (make it visible).
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::update_screen_locked()
{
    draw_screen_locked();
    gr_flip();
}

// Updates only the progress bar, if possible, otherwise redraws the screen.
// Should only be called with updateMutex locked.
void ScreenRecoveryUI::update_progress_locked()
{
    if (show_text || !pagesIdentical) {
        draw_screen_locked();    // Must redraw the whole screen
        pagesIdentical = true;
    } else {
        draw_progress_locked();  // Draw only the progress bar and overlays
    }
    gr_flip();
}

// Keeps the progress bar updated, even when the process is otherwise busy.
void* ScreenRecoveryUI::progress_thread(void *cookie) {
    self->progress_loop();
    return NULL;
}

void ScreenRecoveryUI::progress_loop() {
    double interval = 1.0 / animation_fps;
    for (;;) {
        double start = now();
        pthread_mutex_lock(&updateMutex);

        int redraw = 0;

        // update the installation animation, if active
        // skip this if we have a text overlay (too expensive to update)
        if ((currentIcon == INSTALLING_UPDATE || currentIcon == ERASING) &&
            installing_frames > 0 && !show_text) {
            installingFrame = (installingFrame + 1) % installing_frames;
            redraw = 1;
        }

        // update the progress bar animation, if active
        // skip this if we have a text overlay (too expensive to update)
        if (progressBarType == INDETERMINATE && !show_text) {
            redraw = 1;
        }

        // move the progress bar forward on timed intervals, if configured
        int duration = progressScopeDuration;
        if (progressBarType == DETERMINATE && duration > 0) {
            double elapsed = now() - progressScopeTime;
            float p = 1.0 * elapsed / duration;
            if (p > 1.0) p = 1.0;
            if (p > progress) {
                progress = p;
                redraw = 1;
            }
        }

        if (redraw) update_progress_locked();

        pthread_mutex_unlock(&updateMutex);
        double end = now();
        // minimum of 20ms delay between frames
        double delay = interval - (end-start);
        if (delay < 0.02) delay = 0.02;
        usleep((long)(delay * 1000000));
    }
}

void ScreenRecoveryUI::LoadBitmap(const char* filename, gr_surface* surface) {
    int result = res_create_surface(filename, surface);
    if (result < 0) {
        LOGE("missing bitmap %s\n(Code %d)\n", filename, result);
    }
}

void ScreenRecoveryUI::LoadLocalizedBitmap(const char* filename, gr_surface* surface) {
    int result = res_create_localized_surface(filename, surface);
    if (result < 0) {
        LOGE("missing bitmap %s\n(Code %d)\n", filename, result);
    }
}

void ScreenRecoveryUI::Init()
{
    /* add by cjcheng start... */
    const struct { gr_surface* surface; const char *name; } BITMAPS[] = {
        { &gTipTitle[TIP_TITLE_READY],                  "tip_ready" },
        { &gTipTitle[TIP_TITLE_INSTALL_PACKAGE],        "tip_install_package" },
        { &gTipTitle[TIP_TITLE_READ_PACKAGE],           "tip_read_package" },
        { &gTipTitle[TIP_TITLE_WIPE_DATA],              "tip_wipe_data" },
        { &gTipTitle[TIP_TITLE_WIPE_CACHE],             "tip_wipe_cache" },
        { &gTipTitle[TIP_TITLE_SUCCESS],                "tip_success" },
        { &gTipTitle[TIP_TITLE_ERROR],                  "tip_error" },
        { &gTitleNotPowerOff,                           "title_not_power_off" },
        { &gTitleNotUnplug,                             "title_not_unplug" },
        { NULL,                             NULL },
    };
    /* add by cjcheng end... */

    gr_init();

    text_col = text_row = 0;
    text_rows = gr_fb_height() / CHAR_HEIGHT;
    if (text_rows > kMaxRows) text_rows = kMaxRows;
    text_top = 1;

    text_cols = gr_fb_width() / CHAR_WIDTH;
    if (text_cols > kMaxCols - 1) text_cols = kMaxCols - 1;

    LoadBitmap("icon_installing", &backgroundIcon[INSTALLING_UPDATE]);
    backgroundIcon[ERASING] = backgroundIcon[INSTALLING_UPDATE];
    LoadBitmap("icon_error", &backgroundIcon[ERROR]);
    backgroundIcon[NO_COMMAND] = backgroundIcon[ERROR];

    LoadBitmap("progress_empty", &progressBarEmpty);
    LoadBitmap("progress_fill", &progressBarFill);

    LoadLocalizedBitmap("installing_text", &backgroundText[INSTALLING_UPDATE]);
    LoadLocalizedBitmap("erasing_text", &backgroundText[ERASING]);
    LoadLocalizedBitmap("no_command_text", &backgroundText[NO_COMMAND]);
    LoadLocalizedBitmap("error_text", &backgroundText[ERROR]);

    int i;
    /* add by cjcheng start... */
    for (i = 0; BITMAPS[i].name != NULL; ++i) {
        LoadBitmap(BITMAPS[i].name, BITMAPS[i].surface);
    }
    /* add by cjcheng end... */

    progressBarIndeterminate = (gr_surface*)malloc(indeterminate_frames *
                                                    sizeof(gr_surface));
    for (i = 0; i < indeterminate_frames; ++i) {
        char filename[40];
        // "indeterminate01.png", "indeterminate02.png", ...
        sprintf(filename, "indeterminate%02d", i+1);
        LoadBitmap(filename, progressBarIndeterminate+i);
    }

    if (installing_frames > 0) {
        installationOverlay = (gr_surface*)malloc(installing_frames *
                                                   sizeof(gr_surface));
        for (i = 0; i < installing_frames; ++i) {
            char filename[40];
            // "icon_installing_overlay01.png",
            // "icon_installing_overlay02.png", ...
            sprintf(filename, "icon_installing_overlay%02d", i+1);
            LoadBitmap(filename, installationOverlay+i);
        }
    } else {
        installationOverlay = NULL;
    }

    pthread_create(&progress_t, NULL, progress_thread, NULL);

    RecoveryUI::Init();
}

void ScreenRecoveryUI::SetLocale(const char* locale) {
    if (locale) {
        char* lang = strdup(locale);
        for (char* p = lang; *p; ++p) {
            if (*p == '_') {
                *p = '\0';
                break;
            }
        }

        // A bit cheesy: keep an explicit list of supported languages
        // that are RTL.
        if (strcmp(lang, "ar") == 0 ||   // Arabic
            strcmp(lang, "fa") == 0 ||   // Persian (Farsi)
            strcmp(lang, "he") == 0 ||   // Hebrew (new language code)
            strcmp(lang, "iw") == 0 ||   // Hebrew (old language code)
            strcmp(lang, "ur") == 0) {   // Urdu
            rtl_locale = true;
        }
        free(lang);
    }
}

void ScreenRecoveryUI::SetBackground(Icon icon)
{
    pthread_mutex_lock(&updateMutex);

    // Adjust the offset to account for the positioning of the
    // base image on the screen.
    if (backgroundIcon[icon] != NULL) {
        gr_surface bg = backgroundIcon[icon];
        gr_surface text = backgroundText[icon];
        overlay_offset_x = install_overlay_offset_x + (gr_fb_width() - gr_get_width(bg)) / 2;
        overlay_offset_y = install_overlay_offset_y +
            (gr_fb_height() - (gr_get_height(bg) + gr_get_height(text) + 15)) / 2; // modify by cjcheng
    }

    currentIcon = icon;
    update_screen_locked();

    pthread_mutex_unlock(&updateMutex);
}

/* add by cjcheng start... */
void ScreenRecoveryUI::SetTipTitle(Tip tip)
{
    pthread_mutex_lock(&updateMutex);

    currentTip = tip;
    update_screen_locked();

    pthread_mutex_unlock(&updateMutex);
}
/* add by cjcheng end... */

void ScreenRecoveryUI::SetProgressType(ProgressType type)
{
    pthread_mutex_lock(&updateMutex);
    if (progressBarType != type) {
        progressBarType = type;
        update_progress_locked();
    }
    progressScopeStart = 0;
    progress = 0;
    pthread_mutex_unlock(&updateMutex);
}

void ScreenRecoveryUI::ShowProgress(float portion, float seconds)
{
    pthread_mutex_lock(&updateMutex);
    progressBarType = DETERMINATE;
    progressScopeStart += progressScopeSize;
    progressScopeSize = portion;
    progressScopeTime = now();
    progressScopeDuration = seconds;
    progress = 0;
    update_progress_locked();
    pthread_mutex_unlock(&updateMutex);
}

void ScreenRecoveryUI::SetProgress(float fraction)
{
    pthread_mutex_lock(&updateMutex);
    if (fraction < 0.0) fraction = 0.0;
    if (fraction > 1.0) fraction = 1.0;
    if (progressBarType == DETERMINATE && fraction > progress) {
        // Skip updates that aren't visibly different.
        int width = gr_get_width(progressBarIndeterminate[0]);
        float scale = width * progressScopeSize;
        if ((int) (progress * scale) != (int) (fraction * scale)) {
            progress = fraction;
            update_progress_locked();
        }
    }
    pthread_mutex_unlock(&updateMutex);
}

void ScreenRecoveryUI::Print(const char *fmt, ...)
{
    char buf[256];
    va_list ap;
    va_start(ap, fmt);
    vsnprintf(buf, 256, fmt, ap);
    va_end(ap);

    fputs(buf, stdout);

    // This can get called before ui_init(), so be careful.
    pthread_mutex_lock(&updateMutex);
    if (text_rows > 0 && text_cols > 0) {
        char *ptr;
        for (ptr = buf; *ptr != '\0'; ++ptr) {
            if (*ptr == '\n' || text_col >= text_cols) {
                text[text_row][text_col] = '\0';
                text_col = 0;
                text_row = (text_row + 1) % text_rows;
                if (text_row == text_top) text_top = (text_top + 1) % text_rows;
            }
            if (*ptr != '\n') text[text_row][text_col++] = *ptr;
        }
        text[text_row][text_col] = '\0';
        update_screen_locked();
    }
    pthread_mutex_unlock(&updateMutex);
}
#define MENU_ITEM_HEADER " - "
#define MENU_ITEM_HEADER_LENGTH strlen(MENU_ITEM_HEADER)


void ScreenRecoveryUI::StartMenu(const char* const * headers, const char* const * items,
                                 int initial_selection) {
    int i;
    pthread_mutex_lock(&updateMutex);
    if (text_rows > 0 && text_cols > 0) {
        for (i = 0; i < text_rows; ++i) {
            if (headers[i] == NULL) break;
            strncpy(menu[i], headers[i], text_cols-1);
            menu[i][text_cols-1] = '\0';
        }
        menu_top = i;
        for (; i < MENU_MAX_ROWS; ++i) {
            if (items[i-menu_top] == NULL) break;
			strcpy(menu[i], MENU_ITEM_HEADER);
            strncpy(menu[i]+MENU_ITEM_HEADER_LENGTH, items[i-menu_top], MENU_MAX_COLS-1-MENU_ITEM_HEADER_LENGTH);
            menu[i][MENU_MAX_COLS-1] = '\0';
        }
        menu_items = i - menu_top;
        show_menu = 1;
        menu_sel = menu_show_start = initial_selection;
        update_screen_locked();
    }
    pthread_mutex_unlock(&updateMutex);
}

int ScreenRecoveryUI::SelectMenu(int sel) {
    int old_sel;
    pthread_mutex_lock(&updateMutex);
    if (show_menu > 0) {
        old_sel = menu_sel;
        menu_sel = sel;
        if (menu_sel < 0) menu_sel = 0;
        if (menu_sel >= menu_items) menu_sel = menu_items-1;
		if(menu_sel<menu_show_start&&menu_show_start>0){
			menu_show_start = menu_sel;
		}
		if(menu_sel-menu_show_start+menu_top>=text_rows){
			menu_show_start = menu_top+menu_sel-text_rows+1;

		}
        sel = menu_sel;
        if (menu_sel != old_sel) update_screen_locked();
    }
    pthread_mutex_unlock(&updateMutex);
    return sel;
}

void ScreenRecoveryUI::EndMenu() {
    int i;
    pthread_mutex_lock(&updateMutex);
    if (show_menu > 0 && text_rows > 0 && text_cols > 0) {
        show_menu = 0;
        update_screen_locked();
    }
    pthread_mutex_unlock(&updateMutex);
}

bool ScreenRecoveryUI::IsTextVisible()
{
    pthread_mutex_lock(&updateMutex);
    int visible = show_text;
    pthread_mutex_unlock(&updateMutex);
    return visible;
}

bool ScreenRecoveryUI::WasTextEverVisible()
{
    pthread_mutex_lock(&updateMutex);
    int ever_visible = show_text_ever;
    pthread_mutex_unlock(&updateMutex);
    return ever_visible;
}

void ScreenRecoveryUI::ShowText(bool visible)
{
    pthread_mutex_lock(&updateMutex);
    show_text = visible;
    if (show_text) show_text_ever = 1;
    update_screen_locked();
    pthread_mutex_unlock(&updateMutex);
}
int* ScreenRecoveryUI::GetScreenPara()
{
  int *ScreenPara = new int[3];
  ScreenPara[0] = menu_top;
  ScreenPara[1] = menu_items;
  ScreenPara[2] = CHAR_HEIGHT;
  return ScreenPara;

}
