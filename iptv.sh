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
  echo '* URL TEST *'
  wget --spider -t 5 -T 10 $line
  if [ $? == 0 ]; then 
   echo $line >> $newfile
  else
   echo '* MPV TEST *'
   mpv --force-window=yes --length=5 $line
   ans=$?
   case $ans in
    "0") echo $line >> $newfile ;;
    "4") echo $line >> $verifile ;;
    *) echo $line >> $deadfile ;;
   esac
  fi
  echo "**************************"
  ((i++))
 done < "$linksfile"
 
  #res=$(curl --head --silent --write-out "%{http_code}" --output dev/null $line)
  #if [[ $res -eq 200 ]]; then echo $line >> $newfile; fi
  #echo $res
  #echo $line >> file$res.txt
  #The result of this method is random

