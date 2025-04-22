#!/bin/bash

set -e  # Exit on error

cd personal

# Build the site with Hugo
hugo --destination ../public

cd ..

# Deploy the contents of public to main
rm -rf .deploy-temp
mkdir .deploy-temp
cp -r public/* .deploy-temp/
cp CNAME .deploy-temp/
cp .nojekyll .deploy-temp/

# Replace root with public contents
git checkout main
git rm -r .
cp -r .deploy-temp/* .
rm -rf .deploy-temp

git add .
git commit -m "Deploy site"
git push origin main
