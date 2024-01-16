#!/bin/bash

# find which branch has the vulnerable commit 
git branch --all --contains #<vul_commit_hash>
git checkout #<Branch_name>

# create a bach-up branch
git branch backup-branch

git rebase -i #<vul_commit_hash>~1
git reset --hard HEAD~1
git rebase --continue
git push origin #<vul_commit_hash> --force
