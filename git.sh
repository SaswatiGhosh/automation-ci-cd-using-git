#!/bin/bash


# Author: [Your Name]
# Date: [Today's Date]


current_status=$(git status )
while true
do
    if [ "$current_status" == "nothing to commit, working tree clean" ]; then 
    echo "Git status is not as expected.Change is there."
    git add .
    git commit -m "Automated commit from CI/CD pipeline"
    git push origin main
    fi
    sleep 60
done