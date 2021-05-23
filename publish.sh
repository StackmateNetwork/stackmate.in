#!/bin/sh
# If a command fails then the deploy stops
set -e

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Create commit message
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi

# Build the project.
echo ""
echo ""
echo "Committing changes to $(pwd)"
hugo -D

# Go To Public folder
cd public

# Add 'public' (Github Pages repo) changes to git and commit/push.
echo ""
echo ""
echo "Committing changes to $(pwd)"
git add .
git commit -m "$msg"
git push origin master

# Add this repos changes to git and commit/push. First 'cd' out of public
cd ..
echo ""
echo ""
echo "Committing changes to $(pwd)"
git add .
git commit -m "$msg"
git push origin master
