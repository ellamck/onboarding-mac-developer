# Git Concepts: Staging vs. Committing

## What is the difference between staging and committing?

Staging is essentially picking which files you want in your commit, whereas committing records the changes to the repository along with the commit message. A commit is like
a snapshot of the project.

git reset HEAD file removes file from the staging area (your edits are still there in the working directory).

## Why does Git separate these two steps?

This way, you can selectively decide which files you want to commit, for example, with .env files, you do not want to stage and never want to commit that file. Separating staging and committing allows for that.
It also helps you catch mistakes, and make clean commits that are easy to understand. I find by doing commits in steps (one commit does one responsibility, i.e. adding a field to a database), it helps you debug as well, if the next step you are having issues.
This way, you can fall back on your previous steps.

## When would you want to stage changes without committing?

- When you building commits one step at a time, so you can add each file in a logical
- Can make sure you are separating changes into logical commits
- Testing - if you want to test only a few changes, then you can temporarily stash the unstaged files so you know how your code behaves with parts of your edits
- This also happens when you are completing a merge conflict

# Git Concepts: Branching & Team Collaboration

## Why is pushing directly to main problematic?

It is typically the branch that is deployed in a project, and it is the branch that most other branches are based off of. Because of this, if code is pushed to main that isn't properly reviewed, has bugs, or is broken (fails CI/CD checks), it can stop other people's work and problems can become permanent history.

Basically, main is always meant to be working and deployable, and other branches for development, such as "dev" should be merged into main once there have been thorough and sufficent checks.

## How do branches help with reviewing code?

A branch is an isolated responsibility, for a specific feature or issue, so all the changes on that branch are isolated and focused on that change. Therefore, it is easier to work on a feature in isolation based on the working development branch, and you can still run CI/CD on it. It also allows for pull requests to be made, where code can properly be reviewed by others before it is merged into the working/development branch (and eventually main).

## What happens if two people edit the same file on different branches?

Nothing happens unless they are merging the two branches. If they are merging the two branches, I find that Git is typically able to cleanly merge the code if the changes are on different lines, however, if the same lines are edited, then Git will make a merge conflict that needs to be resolved by someone (typically the person making the merge).
