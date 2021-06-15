import requests
import os
import getopt
import sys

# Sometimes you need to know what types of files are in a github repo along
# with their layout in order to prepare for a risk-reasonable static analysis.
# This script is a model for extracting a list of files in tree format

# This version is for GH enterprise environments where there are organizations
# and repositories.

# INPUTS:
# **Have your github.com PAT in a user environment variable and fetch it from there - or
#   use the practice appropriate for your situation.
# If you handle your PAT differently, adjust the code.
#   -u <user> -- where this is your github.com username - the name associated with the PAT
#   -o <organization> -- the target organization name (authorize your PAT for the target orgs)
#   -r <repo> -- the target repository name
#   -b <branch> -- the target branch in the targeted reposity
####


def main(argv):
    if sys.version_info < (3, 7):
        raise Exception("Use only with Python 3.7 or higher")

    username = ''
    orgname = ''
    repo = ''
    branchname = ''

    if not (sys.argv[1:]):
        print('Get list of repo tree file names from github.com.')
        print('Inputs required: getGHorgtree.py -u <user> -o <organization> -r <repo> -b <branch>')
        sys.exit(2)

    try:
        opts, args = getopt.getopt(argv, 'hu:o:r:b:', ['user=','repo=','org=','branch='])
    except getopt.GetoptError as err:
        print(err)
        print('Get list of repo tree file names from github.com.')
        print('getGHorgtree.py -u <user> -o <organization> -r <repo> -b <branch>')
        sys.exit(2)

    for opt, arg in opts:
        if opt == '-h':
            print('Get list of repo tree file names from github.com.')
            print('getGHorgtree.py -u <user> -o <organization> -r <repo> -b <branch>')
            sys.exit()
        elif opt in ("-u", "--user"):
            username = arg
        elif opt in ("-o", "--org"):
            orgname = arg
        elif opt in ("-r", "--repo"):
            repo = arg
        elif opt in ("-b", "--branch"):
            branchname = arg

    """
    username = '<UserNameHere>'
    orgname = '<OrganizationNameHere>'
    repo = '<RepositoryNameHere>'
    branchname = '<branchNameHere>'
    token = '<PersonalTokenFromEnvironmentorSecretStoreHere>'
    # or get the token from the environment:
    """ 
    token = os.environ['GITHUB_TOKEN']
    url = "https://api.github.com/repos/{}/{}/git/trees/{}?recursive=1".format(orgname, repo, branchname)
    reposeparator = "="*80

    # Authenticate & create session
    ####
    gh_session = requests.Session()
    gh_session.auth = (username, token)

    # Fetch repo data
    ####
    r = gh_session.get(url)
    response = r.json()

    # Report
    ####
    print(reposeparator)

    numberoffiles = len(response["tree"])
    print(f"Github user: {username}")
    print(f"Github org:  {orgname}")
    print(f"Github repo: {repo}")
    print(f"Github repo branch: {branchname}")
    print(f"{str(numberoffiles)} files in {orgname}/{repo}/{branchname} include: ")
    for file in response["tree"]:
        print(file["path"])

    print(reposeparator)


if __name__ == '__main__':
    main(sys.argv[1:])
