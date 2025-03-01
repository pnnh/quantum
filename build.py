#!/usr/bin/env python3

import subprocess
import shutil
import os

def check_os():
    if os.name == 'nt':
        return "Windows"
    elif os.name == 'posix':
        import platform
        if platform.system() == 'Darwin':
            return "macOS"
        else:
            return "Other POSIX"
    else:
        return "Unknown"

def delete_folder(folder_path):
    if os.path.exists(folder_path):
        shutil.rmtree(folder_path)
        print(f"Folder '{folder_path}' has been deleted.")
    else:
        print(f"Folder '{folder_path}' does not exist.")


def make_xcframework():
    print("Creating xcframework...")
    xcframework_path = "macos/quantum/Frameworks/MTQuantum.xcframework"
    # 先删除旧的 xcframework
    delete_folder(xcframework_path)
    cmdText = f'''
        xcodebuild -create-xcframework -framework src/build/macos/Debug/MTQuantum.framework \
            -output {xcframework_path}
    '''
    gedit_pid = subprocess.getoutput(cmdText).strip()
    print(gedit_pid)

def scan_files(directory, file_extension):
    """
    Scan the directory for files with the specified extension.

    :param directory: The directory to scan.
    :param file_extension: The file extension to look for.
    :return: A list of paths to the files with the specified extension.
    """
    matched_files = []
    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith(file_extension):
                matched_files.append(os.path.join(root, file))
    return matched_files

def copy_dll():
    print("Copying dll...")
    files = scan_files("src\\build\\Windows\\Debug", ".dll")
    if files:
        print(f"Found {len(files)} files.")
        for file in files:
#             print("====", file, "windows\\libraries\\" + os.path.basename(file))
            shutil.copy(file, "windows\\libraries\\" + os.path.basename(file))
    print("Copy dll finished.")

os_type = check_os()
if os_type == "macOS":
    print("macOS")
    # 创建 xcframework
    make_xcframework()
elif os_type == "Windows":
    print("Windows")
    copy_dll()
else:
    print("Other OS")