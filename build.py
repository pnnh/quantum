#!/usr/bin/env python3

import subprocess
import shutil
import os

def delete_folder(folder_path):
    if os.path.exists(folder_path):
        shutil.rmtree(folder_path)
        print(f"Folder '{folder_path}' has been deleted.")
    else:
        print(f"Folder '{folder_path}' does not exist.")

xcframework_path = "macos/quantum/Frameworks/MTQuantum.xcframework"

def make_xcframework():
    print("Creating xcframework...")
    cmdText = f'''
        xcodebuild -create-xcframework -framework src/build/macos/Debug/MTQuantum.framework \
            -output {xcframework_path}
    '''
    gedit_pid = subprocess.getoutput(cmdText).strip()
    print(gedit_pid)

# 先删除旧的 xcframework
delete_folder(xcframework_path)
# 创建 xcframework
make_xcframework()