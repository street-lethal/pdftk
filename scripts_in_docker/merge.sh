#!/bin/bash

pdftk *.pdf cat output merged.pdf
chown 1000:1000 merged.pdf
