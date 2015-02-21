#!/bin/bash
#
# Get all images from 4chan thread
# liammcd Feb 2015

if [ $# = 0 ]; then
	echo 'Usage: ./4chget.sh [thread url]'
	exit
fi

LINK=$1
BOARD=${LINK#http*://*/*}
THREAD=${BOARD##*/*/}
BOARD=${BOARD%%/*}
DIR="$BOARD-$THREAD"

echo 'Board: ' $BOARD

mkdir -p $DIR ; cd $DIR

curl $LINK -o 'orig.html'
tr ' ' '\n' < orig.html > tmp.html
grep -oh 'i.4cdn.org/*/.*jpg' tmp.html > jpgs.txt
grep -oh 'i.4cdn.org/*/.*png' tmp.html > pngs.txt
if [[ -s jpgs.txt ]]; then
	sort -u jpgs.txt | grep -v 's.*' | wget -i -
fi
if [[ -s pngs.txt ]]; then
	sort -u pngs.txt | grep -v 's.*' | wget -i -
fi 

#clean up
rm orig.html tmp.html jpgs.txt pngs.txt
