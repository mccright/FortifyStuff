import requests
import os

# Sometimes you need to know what types of files are in a github repo along
# with their layout in order to prepare for a risk-reasonable static analysis.
# This script is a model for extracting a list of files in tree format

# This version is for GH enterprise environments where there are organizations
# and repositories.

# inputs
####
"""
username = '<UserNameHere>'
orgname = '<OrganizationNameHere>'
repo = '<RepositoryNameHere>'
# or get username, orgname, & repo from the command line
token = '<PersonalTokenFromEnvironmentorSecretStoreHere>'
# for example: token = os.environ['GITHUB_TOKEN']
url = "https://api.github.com/repos/{}/{}/git/trees/main?recursive=1".format(orgname, repo)
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
print(f"Github user: {orgname}")
print(f"Github repo: {repo}")
print(f"{str(numberoffiles)} files in {orgname}/{repo} include: ")
for file in response["tree"]:
    print(file["path"])

print(reposeparator)
