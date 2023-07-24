#!/bin/bash

STR=$(<clipboard_file.txt)
echo "$STR"
SUB='RUN'
if [[ "$STR" == *"$SUB"* ]]; then
  echo "It's there."
fi