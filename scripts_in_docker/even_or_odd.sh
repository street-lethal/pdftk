#!/bin/bash
cd input
ls  *.pdf > /tmp/filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "$filename" /tmp/tmp_input.pdf
  cp "$without_ext.txt" /tmp/tmp_input.txt
  pdftk /tmp/tmp_input.pdf cat $MODE output /tmp/output.pdf
  mv /tmp/output.pdf ../output/"$without_ext".pdf
  rm /tmp/tmp_input.*
done < /tmp/filenames.txt
rm /tmp/filenames.txt
