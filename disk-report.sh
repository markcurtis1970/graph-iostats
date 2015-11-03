#!/bin/bash
#
# Loop through all discs to produce the iostat graphs

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
    ./iostat-readwrite-requests.sh $IOSTATS $DISK $DISK-requests.png
    ./iostat-readwrite-throughput.sh $IOSTATS $DISK $DISK-throughput.png
    ./iostat-queue-length.sh $IOSTATS $DISK $DISK-queue-length.png
    ./iostat-queue-size.sh $IOSTATS $DISK $DISK-queue-size.png
    ./iostat-service.sh $IOSTATS $DISK $DISK-service.png
    ./iostat-utilisation.sh $IOSTATS $DISK $DISK-utilisation.png
done < $DISKS
