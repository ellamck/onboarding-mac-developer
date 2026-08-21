# Static Analysis Checks in CI/CD

## What is the purpose of CI/CD?

- CI/CD catches bugs automatically and early
- Enforces code standards automatically
- Helps with integration and merging changes frequently
- Like tests, it helps with verifying your refactor didn't introduce issues
- Provides feedback on PRs for reviewers (it passes tests before they review it, so they know it is working in some capacity)

## How does automating style checks improve project quality?

- It catches problems early
- Automates inconsistency checks, which helps the developers focus on larger problems
- Is similar to Docker in the sense that it prevents any environmental-specific differences
- Maintains consistency and standards on the codebase

## What are some challenges with enforcing checks in CI/CD?

- When you first set it up, all the "errors" that were not found before instantly appear, and this blocks progress because they need to be addressed
- If you have too strict of rules, it is just frustrating and not actually helpful. I found this true with the Lint checker I had to implement, it was finding errors like "too many headers in one file" that are neglible for my circumstance
- I imagine these would be difficult to set up for large-scale projects with multiple pipelines

## How do CI/CD pipelines differ between small projects and large teams?

- CI/CD pipelines in smaller teams seem to be simpler and it goes from PR to merge faster
- Large teams seem to tend to have multiple pipeline stages that run in parallel
- Different teams may be responsible for different pipelines in a big team
- I read that larger scale projects tend to use staged rollouts, to carefully vet for bugs
