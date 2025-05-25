#!/bin/bash

pdftk ../input/*.pdf cat output ../output/merged.pdf
chown 1000:1000 ../output/merged.pdf
