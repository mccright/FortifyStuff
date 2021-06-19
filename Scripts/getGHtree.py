#!/usr/bin/python
import getopt
import sys
import requests

# Sometimes you need to know what types of files are in a github repo along with their layout 
# in order to prepare for a risk-reasonable static analysis.
# This script is a model for extracting a list of files in tree format.
# See: https://docs.github.com/en/rest/reference/git#trees
#      https://stackoverflow.com/questions/25022016/get-all-file-names-from-a-github-repo-through-the-github-api


def main(argv):
    if sys.version_info < (3, 7):
        raise Exception("Use only with Python 3.5 or higher")
    user = ''
    repo = ''
    if not (sys.argv[1:]):
        print('Get list of repo tree file names from github.com.')
        print('Inputs required: getGHtree.py -u <user> -r <repo>')
        sys.exit(2)

    try:
        opts, args = getopt.getopt(argv, 'hu:r:b:', ['user=', 'repo=', 'branch='])
    except getopt.GetoptError as err:
        print(err)
        print('Get list of repo tree file names from github.com.')
        print('getGHtree.py -u <user> -r <repo> -b <branch>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('Get list of repo tree file names from github.com.')
            print('gettest.py -u <user> -r <repo> -b <branch>')
            sys.exit()
        elif opt in ("-u", "--user"):
            user = arg
        elif opt in ("-r", "--repo"):
            repo = arg
        elif opt in ("-b", "--branch"):
            branchname = arg

    # Test Data:
    # user = "mccright"
    # repo = "PythonLoggingExamples"

    url = "https://api.github.com/repos/{}/{}/git/trees/{}?recursive=1".format(user, repo, branchname)
    r = requests.get(url)
    res = r.json()
    numberoffiles = len(res["tree"])
    print(f"Github user: {user}")
    print(f"Github repo: {repo}")
    print(f"{str(numberoffiles)} files in {user}/{repo} include: ")
    for file in res["tree"]:
        print(file["path"])


if __name__ == '__main__':
    main(sys.argv[1:])
