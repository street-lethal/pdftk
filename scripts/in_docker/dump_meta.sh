#!/bin/bash
cd input
ls *.pdf > /tmp/filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "$filename" /tmp/tmp_input.pdf
  pdftk /tmp/tmp_input.pdf dump_data > /tmp/tmp_input.txt
  mv /tmp/tmp_input.txt /app/output/"$without_ext.txt"
  rm /tmp/tmp_input.*
done < /tmp/filenames.txt
rm /tmp/filenames.txt
