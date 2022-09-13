#!/bin/sh
imzala=/imza/imzala_dosya.sh

for file in "$1"/*
do
  if [ ! -d "$file" ]; then
        $imzala "$file"
  fi
done
