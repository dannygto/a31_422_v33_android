#!/system/bin/sh

FILE_PATH=/data/local/logs

FILE_PREFIX_KERNLOG=kernlog
FILE_PREFIX_MAINLOG=mainlog
FILE_PREFIX_RADIOLOG=radiolog

LOGGER_KERNLOG=$1
LOGGER_MAINLOG=$2
LOGGER_RADIOLOG=$3

#sleep 30
if [ ! -d $FILE_PATH ]
then
mkdir -p $FILE_PATH
fi

rename_logfile()
{
	FILE_PREFIX=$1
	LAST_LAST_LAST_FILE=`busybox find $FILE_PATH/ -name "$FILE_PREFIX-*.log.last.last"`
	LAST_LAST_FILE=`busybox find $FILE_PATH/ -name "$FILE_PREFIX-*.log.last"`
	LAST_FILE=`busybox find $FILE_PATH/ -name "$FILE_PREFIX-*.log"`
	#change log files name
	echo "$LAST_LAST_LAST_FILE $LAST_LAST_FILE $LAST_FILE"
	rm $LAST_LAST_LAST_FILE
	mv $LAST_LAST_FILE $LAST_LAST_FILE.last
	mv $LAST_FILE $LAST_FILE.last
}

logger_kmsg()
{
	echo "logger $FILE_PREFIX_KERNLOG ..."
	rename_logfile $FILE_PREFIX_KERNLOG
	busybox cat /proc/kmsg > $FILE_PATH/$FILE_PREFIX_KERNLOG-`date +%Y%m%d-%H%M`.log &
}

logger_logcat()
{
	echo "logger $FILE_PREFIX_MAINLOG ..."
	rename_logfile $FILE_PREFIX_MAINLOG
	logcat -v time -f $FILE_PATH/$FILE_PREFIX_MAINLOG-`date +%Y%m%d-%H%M`.log &
}

logger_radio()
{
	echo "logger $FILE_PREFIX_RADIOLOG ..."
	rename_logfile $FILE_PREFIX_RADIOLOG
	logcat -v time -b radio -f $FILE_PATH/$FILE_PREFIX_RADIOLOG-`date +%Y%m%d-%H%M`.log &
}

if [ $LOGGER_KERNLOG != "0" ];then
	logger_kmsg
fi

if [ $LOGGER_MAINLOG != "0" ];then
	logger_logcat
fi

if [ $LOGGER_RADIOLOG != "0" ];then
	logger_radio
fi

sleep 100000000
