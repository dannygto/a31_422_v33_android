ifeq ($(BOARD_HAVE_BLUETOOTH), true)
ifeq ($(BOARD_HAVE_BLUETOOTH_RTK), true)
ifeq ($(SW_BOARD_USR_WIFI), rtl8723au)
	include $(call all-subdir-makefiles)
endif
endif	
endif

