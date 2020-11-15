#!/bin/bash

# Compile all the latex files

for filename in $(find . -type f -name '*.tex')
do
    echo "Inspecting $filename"
    ./bin/compile_pdf.sh $filename
done
