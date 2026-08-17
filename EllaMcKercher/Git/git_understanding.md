# Git Concepts: Staging vs. Committing

## What is the difference between staging and committing?

Staging is essentially picking which files you want in your commit, whereas committing records the changes to the repository along with the commit message. A commit is like
a snapshot of the project.

git reset HEAD <file> removes <file> from the staging area (your edits are still there in the working directory).

## Why does Git separate these two steps?

This way, you can selectively decide which files you want to commit, for example, with .env files, you do not want to stage and never want to commit that file. Separating staging and committing allows for that.
It also helps you catch mistakes, and make clean commits that are easy to understand. I find by doing commits in steps (one commit does one responsibility, i.e. adding a field to a database), it helps you debug as well, if the next step you are having issues.
This way, you can fall back on your previous steps.

## When would you want to stage changes without committing?

- When you building commits one step at a time, so you can add each file in a logical 
- Can make sure you are separating changes into logical commits
- Testing - if you want to test only a few changes, then you can temporarily stash the unstaged files so you know how your code behaves with parts of your edits
- This also happens when you are completing a merge conflict