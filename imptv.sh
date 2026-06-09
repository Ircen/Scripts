#!/bin/bash

linksfile=$(zenity --file-selection --title='IPTV Links File')
newfile=${linksfile%.txt}WORKING.txt
verifile=${linksfile%.txt}VERIFY.txt
deadfile=${linksfile%.txt}DEAD.txt
i=1

while read line;
 do
  echo "******* LINK N° $i *******"
  echo $line
  echo '* MPV TEST *'
  mpv --force-window=yes --length=5 $line
  ans=$?
  case $ans in
    "0") echo $line >> $newfile ;;
    "4") echo $line >> $verifile ;;
    *) echo $line >> $deadfile ;;
  esac
  echo "**************************"
  ((i++))
 done < "$linksfile"

