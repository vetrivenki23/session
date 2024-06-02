@echo off
set /p description="Enter commit description: "
git add .
git commit -m "%description%"
git branch -M main
git push -u origin main
