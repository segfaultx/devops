#! /bin/bash

file $(find $*) | grep "POSIX shell script" | sort | cut -f1 -d: