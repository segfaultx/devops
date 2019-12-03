#! /usr/bin/env python3

import os

BASEDIR = "/var/www/html/packages"

count_data = {}

NAME, RESULT, CHANGES, COMMENT = "name", "result", "changes", "comment"

def update(directory=BASEDIR, *args):
    result = {NAME: "update", RESULT: False, CHANGES: {}, COMMENT: ""}
    info = os.system(f"/usr/bin/update-packages-index.sh {directory}")
    if info == 0: # Script exits with 0 on success
        result[RESULT] = True
        result[COMMENT] = f"Packageupdate successful. Path: {directory}"
        return result
    else:
        result[COMMENT] = f"Updatescript exited with code: {info}, directory: {directory}" 
        return result

def stat(directory=BASEDIR, *args):
    global count_data
    subdirs = [dir for dir in os.listdir(directory) if os.path.isdir(os.path.join(directory, dir))] 
    if not subdirs:
        count_data[directory] = len([diritem for diritem in os.listdir(directory) if diritem.endswith(".png")])
        return 
    for subdir in subdirs:
        stat(directory=os.path.join(directory, subdir))
    count_data[directory] = len([diritem for diritem in os.listdir(directory) if diritem.endswith(".png")])
    return count_data

if __name__ == "__main__":
    print(stat(directory="/home/amatus/Pictures/"))