#!/bin/bash

if test -z "$*"; then
 linksfile=$(zenity --file-selection --title='IPTV Links File')
else
 linksfile=$*
fi

echo "The file is $linksfile"
newfile=${linksfile%.txt}.json
comma=\",\"
colon=\":\"
i=1
text=[

cut -d '&' -f -2 $linksfile >> $newfile
sed -i 's/\/get.php?/","/g' $newfile
sed -i 's/&/","/g' $newfile
sed -i 's/=/":"/g' $newfile

while read line;
do
  title="$(echo $line | cut -d '/' -f 3 | cut -c -4) $i"
  time=$(date +%FT%T.000Z)
  linkid=$(date +%y%j-%H%M%S-%N)
  text=$text'{"_id'$colon$linkid$comma'title'$colon$title$comma'serverUrl'$colon$line$comma'importDate'$colon$time$comma'autoRefresh":false,"userAgent'$colon$comma'position":'$i},
  #text=$text{\"serverUrl$colon$line$comma'title'$colon$title$comma'_id'$colon$linkid$comma'importDate'$colon$time$comma'autoRefresh":false,"userAgent'$colon$comma'position":'$i},
  
  ((i++))
done < "$newfile"

text=${text%,}]
echo $text> $newfile
