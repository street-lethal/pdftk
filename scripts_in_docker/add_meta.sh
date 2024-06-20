#!/bin/bash
ls  *.pdf > filenames.txt
while read filename
do
  export without_ext=$(echo $filename | sed -e "s/\.pdf\$//")
  pdftk $filename update_info_utf8 $without_ext.txt output "$without_ext"_meta.pdf
  chown 1000:1000 "$without_ext"_meta.pdf
done < filenames.txt
rm filenames.txt
