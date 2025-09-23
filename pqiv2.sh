#!/bin/sh

myfile=$1
echo $myfile
#Verify the argument
if test -z "$myfile"; then
 myfile=$(zenity --file-selection)
fi

#Session options
case $(echo $XDG_SESSION_TYPE) in
  'wayland')
    xoption=-ctn
    ;;
  'x11')
    xoption=-itn
    ;;
esac

#Execute by filetype
case "$myfile" in
  *.pdf)
  echo 'its pdf'
  pqiv $xoption -T '$BASEFILENAME [$IMAGE_NUMBER/$IMAGE_COUNT]' --scale-mode-screen-fraction=0.9 "$myfile"
  ;;
  *)
  echo 'its image'
  pqiv $xoption -T '[$IMAGE_NUMBER/$IMAGE_COUNT] $BASEFILENAME $ZOOM%' --browse --max-depth=1 "$myfile"
esac
