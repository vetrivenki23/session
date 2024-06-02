#!/bin/bash

read -p "Enter commit description: " description
git add .
git commit -m "$description"
git branch -M main
git push -u origin main

