# Understanding Clean Code Principles

## Research and summarize the following clean code principles in clean_code.md:

**Simplicity**
Keep code as simple as possible: solve the problem or add the feature in the most straightforward way.

**Readability**
Code should be easy to understand, and documented accordingly. Someone who doesn't know the codebase should be able to understand what the function does from the documentation and the code.

**Maintainability**
The code should be easy to modify and work with, and non-dependent on the person who added the code (people in the team should find it easy to update, extend etc.).

**Consistency**
Code should follow style guides and project conventions, this includes:

- Clear, focused code commits
- Components that are as decoupled as possible
- File structures are organised and standardised
- File naming matches the standards, etc.

Code should be the same across different team members, in regards to above.

**Efficiency**
Code should be efficient and execute in reasonable time, without using inappropriate amounts of memory. Premature over-engineering is when optimisation is attempted before writing the code - general advice is to write clean simple code first, and then optimise the lagging parts _after_.

## Find an example of messy code online (or write one yourself) and describe why it's difficult to read.

I found this example on Dev.to (https://dev.to/andriy_ovcharov_312ead391/how-to-refactor-chaotic-javascript-code-a-step-by-step-guide-56e9):

`function doStuff(x, y) {
  let z = x + y;
  if (z > 0) {
    let arr = [];
    for (let i = 0; i < x; i++) {
      arr.push(i * y);
    }
    return arr;
  }
  return [];
}`

- The function has no documentation above it, so there is no context
- The function's name is non-descriptive
- There are repeated variables
- The variables themselves have unclear names
- The function also has multiple responsibilities

## Rewrite the code in a cleaner, more structured way.

`This function returns an array that has the multiples of the provided multipler parameter.
It only does this if numberOfItems is positive.
function getMultiples(numberOfItems, multiplier) {
// The original check was non-sensical
if (numberOfItems > 0) {
return findMultiples(numberOfItems, multiplier);
}
return [];
}`

`This function generates an array of multiples of the multiplier parameter.
function findMultiples(numberOfItems, multiplier) {
let multiplesList = [];
for (let i = 0; i < numberOfItems; i++) {
multiplesList.push(i \* multiplier);
}
return multiplesList;
}`

# Code Formatting & Style Guides

## Why is code formatting important?

I believe it helps with consistency across a codebase, especially for development as a team. I noted another reason why this is important is because it improves readability of the code, making code review and understanding more efficient and effective. It also can reduce pull request merge conflict issues with diffs, as sometimes even a space difference can set off Git.

## What issues did the linter detect?

Just simple doc formatting issues with the README.md file and my First_Time_User_Experience.md file. It fixed spacing and numbering.

## Did formatting the code make it easier to read?

The change wasn't overly impactful for me, as this codebase is mainly documentation so far, but I have used Prettier and ESLint in the past and I definitely find using it worthwhile. It makes code, especially code shared in a team, easier to read and more consistent.

# Naming Variables & Functions

## What makes a good variable or function name?

Non-ambiguous, clear and short names. Variables are descriptive of what they are, functions are actions, and booleans begin with is or has. camelCase is normally used.

## What issues can arise from poorly named variables?

It takes a considerable amount of time to understand and review the code. It makes reading the code harder, and it creates unfamiliarity amongst teammates and reviewers. If the intent of the code is not clear, issues can also be harder to track down or diagnose.

## How did refactoring improve code readability?

Originally, there was a lot of questions and I spent a lot of mental effort just trying to understand what the code did. Once I had figured out better naming for each variable, I could actually understand the function's purpose. You do not have to figure out what each function does or what each variable is on the refactor, and it allows you to understand the code clearly and it takes less mental effort to verify the intended behaviour of the code.

Additionally, splitting from one bloated function to two functions ensure the responsibility was atomic for each function, making it easier to understand.

# Writing Small, Focused Functions

## Why is breaking down functions beneficial?

It ensures functions have isolated, specific responsibilities, and this makes it not only easier to understand them, but easier to trace unintended behaviour. It also helps when testing, it is so much easier to test one responsibility in one test.

## How did refactoring improve the structure of the code?

It split a bloated function into two, with a clear responsibility for both. The first function delegates, so it is easier to understand why the positive check occurs, and when the generation of multiples should occur. Two functions made it easier to catch any logic bugs, and the flow of control is easy to understand (the first function calls upon the second).
