import os
import sys
import shutil
import traceback
import subprocess as sp
from github3 import login
import yaml
scriptDir= os.path.join(os.path.dirname(__file__))
buildDir =os.path.join(scriptDir, 'builds')
with open(os.path.join(scriptDir, '.tf47Config.yml'), 'r') as ymlfile:
    cfg = yaml.load(ymlfile)

REPOUSER = cfg['GitHub']['org']
REPONAME = cfg['GitHub']['repo']
REPOPATH = "{}/{}".format(REPOUSER,REPONAME)

def create_release(repo):
    label = sp.check_output(["git", "describe", "--tags"]).decode('ascii').strip().split("-")[0]
    label = 'v{}-beta.{}'.format(label, os.environ["TRAVIS_BUILD_NUMBER"])
    print(label)
    release = repo.create_release(label, prerelease=True, draft=True)
    for file in os.listdir(buildDir):
        if file.endswith(".pbo"):
            release.upload_asset(content_type="application/octet-stream", name=file, asset=open(os.path.join(buildDir, file), "rb").read())


def main():
    print("Obtaining token ...")
    try:
        token = os.environ["GH_TOKEN"]
        g =login(token=token)
        repo = g.repository(REPOUSER, REPONAME)
    except:
        print("Could not obtain token.")
        print(traceback.format_exc())
        return 1
    else:
        print("Token sucessfully obtained.")

    print("\nCreating Release")
    try:
        create_release(repo)
    except:
        print("Failed to update translation issue.")
        print(traceback.format_exc())
        return 1
    else:
        print("Translation issue successfully updated.")

    return 0


if __name__ == "__main__":
    sys.exit(main())