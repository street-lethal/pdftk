#!/bin/bash
cd input
ls  *.pdf > /tmp/filenames.txt
cd /app
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "input/$filename" /tmp/tmp_input.pdf
  pdftk /tmp/tmp_input.pdf cat $(/app/bin/main_linux) output /tmp/output.pdf
  mv /tmp/output.pdf "/app/output/$without_ext.pdf"
  rm /tmp/tmp_input.*
done < /tmp/filenames.txt
rm /tmp/filenames.txt
