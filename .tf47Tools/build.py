import os
import shutil
import subprocess as sp
import sys
import traceback

import yaml

# GLOBALS
with open(".tf47Config.yml", 'r') as ymlfile:
    cfg = yaml.load(ymlfile)
platform = sys.platform


def createmapvariants():
    path = '../.tf47MapVariants'
    files = os.listdir(path)
    for island in files:
        if os.path.isdir(
                os.path.join(os.path.abspath(path), island)):  # check whether the current object is a folder or not
            dest = "builds/{}.{}".format(cfg['Info']['project'], island)
            # pathlib.Path().mkdir(parents=True, exist_ok=True)
            shutil.copytree('../', dest,
                            ignore=shutil.ignore_patterns('.tf47Tools', '.tf47MapVariants', '.git', '.DS_Store',
                                                          '.gitignore'))
            root_src_dir = os.path.join(os.path.abspath(path), island)
            root_dst_dir = dest
            for src_dir, dirs, files in os.walk(root_src_dir):
                dst_dir = src_dir.replace(root_src_dir, root_dst_dir, 1)
                if not os.path.exists(dst_dir):
                    os.makedirs(dst_dir)
                for file_ in files:
                    src_file = os.path.join(src_dir, file_)
                    dst_file = os.path.join(dst_dir, file_)
                    if os.path.exists(dst_file):
                        os.remove(dst_file)
                    shutil.copy(src_file, dst_dir)


def createpbos():
    path = 'builds'
    files = os.listdir(path)
    for island in files:
        if os.path.isdir(
                os.path.join(os.path.abspath(path), island)):  # check whether the current object is a folder or not
            makepbo(island)
            shutil.rmtree(os.path.join(os.path.abspath(path), island))


def makepbo(island):
    if platform == "linux" or platform == "linux2" or platform == "darwin":
        # armake build -p Insurgency/ Insurgency.altis.pbo
        sp.check_output([
            "armake",
            "build",
            "-p",
            "builds/{}".format(island),
            "builds/{}.pbo".format(island)
        ], stderr=sp.STDOUT)
    elif platform == "win32":
        print('Windows not implemented yet')


def main():
    print("\nclean up")
    try:
        shutil.rmtree('builds')
    except FileNotFoundError:
        pass
    except:
        print("could not clean up build directory")
        print(traceback.format_exc())
    else:
        print("clean up succesful")

    print("\nCreating map Variants")
    try:
        createmapvariants()
    except:
        print("could not create map Variants")
        print(traceback.format_exc())
        exit(1)
    else:
        print("created map variants")

    print("\nCreating pbos")
    try:
        createpbos()
    except:
        print("could not create pbo")
        print(traceback.format_exc())
        exit(1)
    else:
        print("created pbos")
    return 0


if __name__ == "__main__":
    sys.exit(main())
