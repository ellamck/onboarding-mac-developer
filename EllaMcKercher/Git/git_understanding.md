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

# Git Concepts: Advanced Git Commands & When to Use Them

## What does each command do?

**git checkout main -- file**

- This pulls out the specific file "file" from the main branch into the current working directory, which overwrites the current file "file" that you had. "--" tells Git that the text after -- is a file path. Your entire branch stays the same, and only that one file "file" is changed (it is staged automatically as well).

**git cherry-pick commit**
– The name speaks for itself, cherry-picking, so this command takes the changes from one specific commit, where "commit" in this command is the commit's hash (I had to remove the side arrows due to markdown format).

- Git will create a new commit with a new hash from this command with a copy of the change.
- This can cause conflicts like a merge can, because Git takes the diff for the file from the commit and tries to apply it to your current branch's version of the file.

**git log**
– This command displays the commit history of the branch you are on.

**git blame <file>**
– This annotates each file's line with information about the last commit that changed it, showing the author, commit hash and timestamp. It only shows the most recent change to the line.

## When would you use it in a real project?

**git checkout main -- file**
– I assume this would be used if you've been working on a file and it is past a point of no return (bad refactor or riddled with bugs you cannot figure out), but the rest of your code on the branch is perfectly fine.

- Whenever you want to just reset one file, not your whole branch.

**git cherry-pick <commit>**
– Perhaps if a teammate has pushed another important bug fix on another branch and you need that fix on your branch too. Essentially, when you need just one commit from another branch, but not the unrelated commits.

**git log**
– When you are trying to understand changes across and within files.

- Perhaps if you are following a bug, or reviewing a pull request.

**git blame file**
– Whenever I would need to know who wrote a line of code and when they did. The commit message could also indicate why they wrote that line of code, so could help in finding a bug or performing a code review.

## What surprised you while testing these commands?

- When using checkout, if you had any uncommitted changes to that file they're just gone immediately, and that you need to be careful with this as Git does not check if this action is what you for sure want to do. It is a complete overwrite.
- For cherry-pick, even though its the same change it produces a new commit with a new hash.
- For git log, I was surprised that git log doesn't show commit history from other branches. It made sense thinking about it, but at first I was confused.
- git blame, I didn't find anything particularly interesting on my repo, but using it on other projects I found if someone did a wide-scale change like adding a new Vscode setting (Prettier for instance) the freshest change is that author for _every single line_.

# Git Concepts: Git Bisect

## What does git bisect do?

It is essentially binary search for finding the right commit where a bug was introduced. You begin bisect, then you indicate which last commit didn't have the bug, and which commit definitely has the bug. Git will check out a commit halfway between the two, and you check the commit, reassigning git bisect good or bad. Git will then find another halfway point, and this is repeated until the commit where the bug is has been found (where you will stop the git bisect).

`git bisect start` this begins a bisect session.

`git bisect bad <commit-hash> /<a tag>/<branch name>/<relative reference like HEAD~10>` this marks a commit as bad (has the bug).

`git bisect good <commit-hash> /<a tag>/<branch name>/<relative reference like HEAD~10>`this marks a commit as good, (bug free).

`git bisect old <commit>` lets you mark a commit that has "old" behaviour (I believe for cases where it is not a bug-finding situation). `git bisect new <commit>` is the opposite, the new behaviour.

`git bisect skip <commit>` this lets you skip a commit and forces Git to pick a different commit.

`git bisect reset` this ends a bisect session, and it returns you to the branch/commit you were on before you started.

## When would you use it in real-world debugging situation?

When you have been working on your branch, and you notice that a bug has been introduced, and you need to resolve it in isolation before you request a code review or merge it in any capacity. Or, after a merge or some new update, code that was working before no longer works, and you need to find the introduced code that causes the issue.

It would be especially useful if multiple people are working on the same feature, or if there have been environment changes.

## How does it compare to manually reviewing commits?

With manual reviews, you would be going through each commit one by one, whereas git bisect allows you to use binary search to find the introduced bad/unintended behaviour. I think git bisect would be best for situations where there is many commits to sort through, however if it is 5ish commits (like I did in my practice), manual is more efficent.

# Git Concepts: Meaningful Commit Messages

## What makes a good commit message?

Convention is to write the commit that describes the changes in a tense that ends the sentence "this commit will **" so "add ** feature" for example. The git message should be clear and each commit should have a logical change/responsibility so its easy to follow. I know some teams have specific message formats as well, my student team used "fix", "feat", to discern differences in changes.

## How does a clear commit message help in team collaboration?

It is easier to gain context from the code, and easier to review code. Clear messages also help teammates understand what is happening with the code, and I think it also helps you write cleaner, easier to interpret code because it forces you to do atomic changes for commits.

From what I learned earlier, it also helps teammates use git blame easier (a good message will explain each line clearly).

## How can poor commit messages cause issues later?

Debugging, from experience, becomes very difficult because it is hard to isolate changes and understand the context of the changes. I find it also wastes the reviewers time, because if the codebase is full of non-descriptive commits, the reviewers and teammates will have to manually try to interpret what is happening.
