import os

root = r"E:\assetsDAZ\main"  # starting folder
target_depth = 2  # because the file lives inside "main\subfolder\subsubfolder\file.zip"

counter = 1
for dirpath, dirnames, filenames in os.walk(root):
    rel_path = os.path.relpath(dirpath, root)
    depth = rel_path.count(os.sep)

    # only look in folders that are 2 levels deeper than root
    if depth == target_depth:
        for filename in filenames:
            if filename.lower().endswith(".zip"):
                print(f"{counter}: {os.path.join(dirpath, filename)}")
                counter += 1
