#!/bin/bash

EXT=".jpg" 
RAW="rawimages.json" 
THUMBS="thumbs"
PREFIX="THUMB_"


echo 'hold on...'


if [ -d $THUMBS ] 
then
    cd $THUMBS
    rm * -rf
else
    mkdir $THUMBS
    cd $THUMBS
fi

# salva o JSON
curl 'https://picsum.photos/v2/list?page=2&limit=22' -o $RAW >  /dev/null 2>&1

# O sed aqui remove " (escaped /") globalmente /g 
wget `(jq '.[] | .download_url' $RAW | sed 's/"//g')` >  /dev/null 2>&1

rm $RAW 

for imagefile in `ls`
do  
   convert $imagefile -resize 200x100 $PREFIX$imagefile$EXT
done

echo 'done.'

