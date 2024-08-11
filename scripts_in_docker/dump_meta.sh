#!/bin/bash
ls  *.pdf > filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "$filename" tmp_input.pdf
  pdftk tmp_input.pdf dump_data > tmp_input.txt
  chown 1000:1000 tmp_input.txt
  mv tmp_input.txt "$without_ext.txt"
  rm tmp_input.*
done < filenames.txt
rm filenames.txt
