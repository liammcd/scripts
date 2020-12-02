#!/bin/bash

for file in *.mp3
do
  title=`id3info $file | grep "TIT2" | cut -c 48-`
  title+=".mp3"
  mv "$file" "$title"
done
