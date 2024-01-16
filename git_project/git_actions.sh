touch file_c1
git add file_c1
git commit -m "c1"
git checkout -b arik/bugfix1
touch file_c10
git add file_c10
git commit -m "c10"
touch file_c11
git add file_c11
git commit -m "c11"
git checkout main
touch file_c2
git add file_c2
git commit -m "c2"
git checkout -b john/feature1
touch file_c3
git add file_c3
git commit -m "c3"
git checkout main
git merge arik/bugfix1
git commit -m "v1.0.2"
git tag v1.0.2
git checkout john/feature1
git checkout -b john/feature1-test
touch file_c5
git add file_c5
git commit -m "c5"
git checkout main
touch file_c6
git add file_c6
git commit -m "c6"
git checkout john/feature1
touch file_c7
git add file_c7
git commit -m "c7"
git checkout main
git merge john/feature1
git commit -m "v1.0.3"
git tag v1.0.3
git checkout john/feature1-test
touch file_c8
git add file_c8
git commit -m "c8"
git tag john-only
git checkout main
touch file_c9
git add file_c9
git commit -m "c9"

git push origin --tags
git push origin main
