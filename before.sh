#!/bin/bash

# Checkout staging because we cant assume the build step has checked out the correct branch.
git fetch
git checkout origin/staging
git branch -D staging 
git checkout -b staging