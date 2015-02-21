#!/bin/bash
# 
# Download all images from an imgur album
# liammcd Feb 21 2015

if [$1 = '']; then
	echo 'Usage: ./imget.sh [full album url]'
	exit 
fi

APATH=$1
NAME=${APATH##http*://*/}

mkdir -p $NAME ; cd $NAME

curl $APATH -o 'tmp.html'
grep -oh 'http://i.imgur.com/.*jpg' tmp.html > urls.txt
sort -u urls.txt | wget -i -

#clean up
rm tmp.html urls.txt
