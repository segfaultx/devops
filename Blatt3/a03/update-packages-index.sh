#!/bin/bash

cd $1

for directory in $(ls -d */); do
    if [ $(find $directory | grep ".deb" | wc -l) -ge 1 ] && [ $(find $directory | grep "Packages.gz" | wc -l) -eq 0 ]; then
        dpkg-scanpackages $directory >$directory/Packages.gz
    else
        if [ $(ls -lt $directory | head -n2 | grep "Packages.gz" | wc -l) -eq 0 ]; then
            dpkg-scanpackages $directory >$directory/Packages.gz
        fi
    fi
done
