#!/bin/bash
ls  *.pdf > filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  cp "$filename" tmp_input.pdf
  cp "$without_ext.txt" tmp_input.txt
  pdftk tmp_input.pdf update_info_utf8 tmp_input.txt output output.pdf
  chown 1000:1000 output.pdf
  mv output.pdf "$without_ext"_meta.pdf
  rm tmp_input.*
done < filenames.txt
rm filenames.txt
