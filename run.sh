#!/bin/bash

echo "Environment Variables"
echo "REPO: ${REPO}"
echo "USERNAME: ${USERNAME}"
echo "TOKEN: ${TOKEN}"

echo "Configuring git"
git config --global hub.protocol "https"
git config --global url."https://${USERNAME}:${TOKEN}@github.com".insteadOf "https://github.com"
git config --global user.email "dev@yunit.co"
git config --global user.name "Fliko"
git config --global --add safe.directory /github/workspace

echo "Initialize GIT"
git init

echo "Cloning repo ${REPO}"
git clone https://github.com/${REPO}.git 

echo "Adding remote for repo ${REPO}"
git remote add origin https://github.com/${REPO}.git

branch=${GITHUB_REF#refs/heads/}
echo "Checking out $branch branch"
git fetch
git checkout origin/$branch
git checkout $branch


echo "Running release-it"
# $1 is the release type major, minor or patch
DEBUG=release-it:* release-it $RELEASE_TYPE --preRelease=staging --ci --no-npm
