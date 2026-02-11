#!/bin/bash
cd input
ls  *.pdf > /tmp/filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "$filename" /tmp/tmp_input.pdf
  cp "$without_ext.txt" /tmp/tmp_input.txt
  pdftk /tmp/tmp_input.pdf update_info_utf8 /tmp/tmp_input.txt output /tmp/output.pdf
  mv /tmp/output.pdf /app/output/"$without_ext".pdf
  rm /tmp/tmp_input.*
done < /tmp/filenames.txt
rm /tmp/filenames.txt
