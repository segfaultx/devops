#!/usr/bin/env python3
"""
Update Skript
"""
import os

def update(pathToUpdate = "/var/www/html/packages"):
    return(os.system("/usr/bin/update-package-index.sh " + pathToUpdate) == 0)

def stat(path = "/var/www/html/packages"):
    out = {}
    for root, dirs, files in os.walk(path, topdown=False):
        if root == path:
            continue
        out[os.path.basename(root)] = len([file for file in files if file.endswith(".deb")])
    return out