# Add a remote for the other repository (GitExerciseOther)
git remote add other_repo #< repo ssh link>

# Fetch the other repository using the remote name
git fetch other_repo

# Create a new branch for merging
git checkout -b merge_branch

# Merge the other repository into the new branch, allowing unrelated histories
git merge other_repo/main --allow-unrelated-histories

# Resolve conflicts (if any)
git add .
git merge --continue

# Commit the changes
git commit -m "Merge GitExerciseOther repository"

# Switch back to main branch
git checkout main

# Merge the changes from the merge_branch
git merge merge_branch

# Push the changes to the main branch of GitProject
git push origin main
