#!/bin/bash
#
# Loop through all discs to produce the iostat graphs
CWD=$(dirname $0)

if [ $# -ne 2 ];then
	echo "Generate the iostat graphs from a list of discs"
	echo ""
	echo "Useage: $0 <file listing disk names> <iostats output>"
	echo ""
	exit 1
fi

DISKS=$1
IOSTATS=$2

while read DISK
do
    $CWD/iostat-readwrite-requests.sh $IOSTATS $DISK $DISK-requests.png
    $CWD/iostat-readwrite-throughput.sh $IOSTATS $DISK $DISK-throughput.png
    $CWD/iostat-queue-length.sh $IOSTATS $DISK $DISK-queue-length.png
    $CWD/iostat-queue-size.sh $IOSTATS $DISK $DISK-queue-size.png
    $CWD/iostat-service.sh $IOSTATS $DISK $DISK-service.png
    $CWD/iostat-utilisation.sh $IOSTATS $DISK $DISK-utilisation.png
done < $DISKS
