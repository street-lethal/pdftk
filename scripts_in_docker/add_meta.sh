#!/bin/bash
cd ../input
ls  *.pdf > ../tmp/filenames.txt
cd ../tmp
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp ../input/"$filename" tmp_input.pdf
  cp ../input/"$without_ext.txt" tmp_input.txt
  pdftk tmp_input.pdf update_info_utf8 tmp_input.txt output output.pdf
  chown 1000:1000 output.pdf
  mv output.pdf ../output/"$without_ext".pdf
  rm tmp_input.*
done < filenames.txt
rm filenames.txt
