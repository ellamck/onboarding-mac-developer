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

# Avoiding Code Duplication

## What were the issues with duplicated code?

I have had a past experience where logic was duplicated in the codebase, and I had to refactor or else I would have had to fix the same bug twice, i.e. bugs then get duplicated as well. This also meant if one of the instances of logic was updated, we had to remember to update the other's logic, and this causes inconsistencies and it is much harder to test.

## How did refactoring improve maintainability?

It is easier to maintain code that has focused responsibilities, and makes changes safer and localised. Also, refactoring made it easier to add extended code, because the actual generative function is decoupled from the delegation logic. Someone unfamiliar with the code could also easily understand what is happening and maintain the code, whereas before they would have had difficulty with understanding due to the bloated responsibility and poorly named functions and variables.

# Refactoring Code for Simplicity

## Research refactoring methods

I found these from Martin Fowler:

- Extract method: moving code from a bloated function/file to its own function
- Extract variable: assign a complicated expression a new local variable so the code is easier to follow
- Remove magic numbers
- Consolidate conditional expression: combine related conditions into one condition
- Remove duplication: make reusable component or method instead

## Messy code

I had difficulty finding online messy code examples, so I asked ChatGPT to generate a messy function:

`function processOrder(order) {`
`let d = 0;`
`if (order.total > 100 && order.total <= 500) {`
`d = order.total * 0.05;`
`} else if (order.total > 500 && order.total <= 1000) {`
`d = order.total * 0.1;`
`} else if (order.total > 1000) {`
`d = order.total * 0.15;`
`}`
`let f = order.total - d;`
`if (order.isMember == true) {`
`f = f - 5;`
`}`
`console.log("Final: " + f);`
`return f;`
`}`

Refactored code:
`const MEMBER_DISCOUNT = 5;`

`function getDiscountRate(total) {`
`if (total > 1000) return 0.15;`
`if (total > 500) return 0.1;`
`if (total > 100) return 0.05;`
`return 0;`
`}`

`function applyMemberDiscount(total, isMember) {`
`return isMember ? total - MEMBER_DISCOUNT : total;`
`}`

`function calculateFinalTotal(order) {`
`const discount = order.total * getDiscountRate(order.total);`
`const totalAfterDiscount = order.total - discount;`
`return applyMemberDiscount(totalAfterDiscount, order.isMember);`
`}`

## What made the original code complex?

- There were vague parameter, variable and function names. This made it hard to understand the function's intent and to follow the flow of the function
- The if conditions were essentially duplicated, overcomplicating the checks
- There are a lot of magic numbers, so it was hard to understand their significance
- The function was bloated with many responsibilities making it harder to debug and understand
- There was a console log line in the code
- There was an `== true` statement on a variable that was already a boolean, redundant

## How did refactoring improve it?

- Each function has one discrete responsibility, clarifying the intent of the function and making it easier to maintain, debug and understand
- Each variable and function's purpose was easily understood from the name
- The conditionals were simplified, making the conditional checks easier to understand and no longer redundant
- Removal of the console log so that that specific responsibility isn't entangled with the primary responsibility of this block of code

# Commenting & Documentation

## Find an example of poorly commented code and rewrite the comments to be more useful.

I found this blog that outlined poorly commented code and their improved examples https://refine.dev/blog/code-comments/:

`// This function gets the items from the database (d) and filters them`
`// based on the user's permissions (p).`
`function getFltItems(d, p) {`
` // ...`
`}`

Improved code:
`function filterItemsByUserPermissions(items, permissions) {`
`// ...`
`}`

This code states the obvious:
`// This is a class for a Car`
`class Car {`
`  // constructor`
`  constructor() {`
`    // ...`
`  }`
`}`

`// increment the count`
`count++;`

And the improved code comments would explain things not inherently obvious, rather than stating the obvious.

## When should you add comments?

That same blog, https://refine.dev/blog/code-comments/, by Özgur Akça outlines a few areas that I found helpful:

- "Good comments don't explain what the code is doing, they explain why"
- Function definitions are a great example of how code typically has a gap between business decisions and the actual implementation of code. Comments can be used to explain the why of the business and product logic
- Documenting solutions that are not obvious (but the code needs to remain that way). Comments can also explain the trade-offs of the implementation
- Formal documentation, like Docstrings and XML comments for libraries or APIs
- Comments can warn for constraints of the current implementation

## When should you avoid comments and instead improve the code?

- When there is poorly named code, you should rename the ambiguities rather than using a comment to temporarily fix it
- You should not comment when the comment is explaining the what, not why, that is when comments are redundant
- If the code is to explain something confusing, it should first be examined if the code itself can be modified before adding the comment
- If the comment is not permanent, that is, the comment's description may not be accurate after some time, the comment likely shouldn't be added

# Handling Errors & Edge Cases

## Research strategies for handling errors and edge cases in code

**Handling errors**
I found this blog by Jesse Warden: https://medium.com/@jesterxl/error-handling-strategies-b82d1b04f105

- Throw, try, catch, finally are ways to implement an error handling strategy
  - Throw makes the code throw an error
  - Try wraps operations in a try block to catch and handle failures gracefully
  - Finally is for when there is clean-up that needs to happen regardless of failure or not
- Explicit returns: this is when the code returns a value that the caller needs to check. This way the function always returns, but the return value itself signals if it failed or not.
- Either typing: this is a more structured explicit return, it is kind of like returning an enum that is a dichotomy - the type returned is either a success value or error value.
- Pattern matching: branching based on the type of value, this is often used with explicit returns.

**Edge cases**
I found this blog by Surendar K S: https://medium.com/@surendarks/steps-to-develop-the-edge-case-skills-in-dsa-4192b76bcb3c

1. Understand the problem deeply
2. Ask questions regarding the problem's nature (e.g. can the array be empty?)
3. Practice thinking in extremes
4. Create test cases manually to cover all possibilities
5. Simulate the algorithm step-by-step (option is to run your code on paper or with a debugger)
6. Use assertions
7. Study edge cases of similar problems/implementations

**Guard clauses**
https://dev.to/clintwinter/use-guard-clauses-for-cleaner-code-3ap7

- Guard clauses are early returns, throws, breaks or continues to catch invalid conditions
- Without these code often ends up deeply nested
- Guard clauses improve readability and helps error handling, keeps the main logic separate

## Function that does not properly handle errors or invalid inputs

`function getAverageAge(users) {`
`  let total = 0;`
`  for (let i = 0; i < users.length; i++) {`
`    total = total + users[i].age;`
`  }`
`  return total / users.length;`
`}`

## Refactored function

`function getAverageAge(users) {`
`  // Guard clauses: reject invalid input immediately, with a clear reason`
`  if (!Array.isArray(users)) {`
`    throw new TypeError("getAverageAge expects an array of users");`
`  }`
`  if (users.length === 0) {`
`    throw new RangeError("Cannot calculate average age of an empty list");`
`  }`

`  let total = 0;`
`  for (let i = 0; i < users.length; i++) {`
`    const age = users[i].age;`
`    if (typeof age !== "number" || Number.isNaN(age)) {`
`      throw new TypeError(`User at index ${i} has an invalid age: ${age}`);`
`    }`
`    total += age;`
`  }`

`  return total / users.length;`
`}`

## What was the issue with the original code?

- There was no check for null input
- No check for an empty array, which is one of the edge cases
- There was no validation logic for user's age, it could be null or NaN, and it wouldn't signal anything is wrong
- No indication to the caller of the function that the function could fail

## How does handling errors improve reliability?

- Most failures can no longer fail silently, this increases visibility of a problem
- It helps with reliability because implementations like adding a Guard Clause can prevent small errors from accumulating into large ones, as the guards catch the issues first and aren't entangled in the main logic
- Errors contain useful information, so if new changes are made or something fails, it is much easier to debug, increasing the reliability of the code
- Reliability is when there is little unpredictability, and handling errors increases the predictability of the code in an informational way

# Writing Unit Tests for Clean Code

## How do unit tests help keep code clean?

- I think it forces you to write code that is atomic and well-focused, as it is difficult to write unit tests for bloated code
- It helps you when refactoring through providing a framework that lets you know if your new changes cause issues or not
- When writing tests, it helps you realise if there are vague functions or code blocks, as it will be hard to discern what to test
- It makes you think about the edge cases and error handling
- In my experience, they also help you catch duplicate code, because you will realise you've already tested that exact functionality before

## What issues did you find while testing?

I noticed I didn't check the edge case of divide by 0, so I implemented throwing an error in that function. I then added a new unit test to determine if the function throws the intended error.

# Identifying & Fixing Code Smells

### Magic Numbers & Strings

https://dev.to/thicha0/magic-strings-magic-numbers-4fa4

`$myModel = new Model();`
`$myModel->status_id = 3; // A magic number`
`$myModel->save();`

Refactored:

`enum MyModelStatuses {`
`...`
`  case CREATED = 3;`
`  case ARCHIVED = 4;`
`...`
`}`

`$myModel = new Model();`
`$myModel->status_id = MyModelStatuses::CREATED->value;`
`$myModel->save();`

Magic numbers or strings are values in code that have no explanation of their meaning.

### Long Functions

I couldn't find any examples of this online, so here is what ChatGPT generated for me:

`function registerUser(formData) {`
`  // Validate name`
`  if (!formData.name || formData.name.trim().length === 0) {`
`    console.log("Error: Name is required");`
`    return null;`
`  }`
`  if (formData.name.length > 50) {`
`    console.log("Error: Name is too long");`
`    return null;`
`  }`

`  // Validate email`
`  if (!formData.email || formData.email.trim().length === 0) {`
`    console.log("Error: Email is required");`
`    return null;`
`  }`
`  if (!formData.email.includes("@") || !formData.email.includes(".")) {`
`    console.log("Error: Email is invalid");`
`    return null;`
`  }`

`  // Validate password`
`  if (!formData.password || formData.password.length < 8) {`
`    console.log("Error: Password must be at least 8 characters");`
`    return null;`
`  }`
`  let hasUpper = false;`
`  let hasNumber = false;`
`  for (let i = 0; i < formData.password.length; i++) {`
`    const char = formData.password[i];`
`    if (char >= "A" && char <= "Z") hasUpper = true;`
`    if (char >= "0" && char <= "9") hasNumber = true;`
`  }`
`  if (!hasUpper || !hasNumber) {`
`    console.log("Error: Password needs an uppercase letter and a number");`
`    return null;`
`  }`

`  // Format the user object`
`  const formattedUser = {`
`    name: formData.name.trim(),`
`    email: formData.email.trim().toLowerCase(),`
`    password: formData.password,`
`    createdAt: new Date(),`
`    isActive: true,`
`    role: "user",`
`  };`

`  // Save to database`
`  console.log("Saving user to DB...");`
`  database.save(formattedUser);`

`  // Send welcome email`
`  console.log("Sending welcome email...");`
` emailService.send(formattedUser.email, "Welcome!",`Hi ${formattedUser.name}, welcome to the app!`);`

`  // Log the registration event`
`  console.log("Logging registration event...");`
`  logger.log(`New user registered: ${formattedUser.email}`);`

`  return formattedUser;`
`}`

Refactored:

`const MIN_PASSWORD_LENGTH = 8;`
`const MAX_NAME_LENGTH = 50;`

`function validateName(name) {`
`  if (!name || name.trim().length === 0) {`
`    return "Name is required";`
`  }`
`  if (name.length > MAX_NAME_LENGTH) {`
`    return "Name is too long";`
`  }`
`  return null;`
`}`

`function validateEmail(email) {`
`  if (!email || email.trim().length === 0) {`
`    return "Email is required";`
`  }`
`  if (!email.includes("@") || !email.includes(".")) {`
`    return "Email is invalid";`
`  }`
`  return null;`
`}`

`function validatePassword(password) {`
`  if (!password || password.length < MIN_PASSWORD_LENGTH) {`
`   return`Password must be at least ${MIN_PASSWORD_LENGTH} characters`;`
`  }`

`  const hasUpper = /[A-Z]/.test(password);`
`  const hasNumber = /[0-9]/.test(password);`

`  if (!hasUpper || !hasNumber) {`
`    return "Password needs an uppercase letter and a number";`
`  }`

`  return null;`
`}`

`function validateRegistrationForm(formData) {`
`  return (`
`    validateName(formData.name) ||`
`    validateEmail(formData.email) ||`
`    validatePassword(formData.password)`
`  );`
`}`

`function formatNewUser(formData) {`
`  return {`
`    name: formData.name.trim(),`
`    email: formData.email.trim().toLowerCase(),`
`    password: formData.password,`
`    createdAt: new Date(),`
`    isActive: true,`
`    role: "user",`
`  };`
`}`

`function saveUser(user) {`
`  database.save(user);`
`}`

`function sendWelcomeEmail(user) {`
` emailService.send(user.email, "Welcome!",`Hi ${user.name}, welcome to the app!`);`
`}`

`function logRegistration(user) {`
`  logger.log(`New user registered: ${user.email}`);`
`}`

`function registerUser(formData) {`
`  const validationError = validateRegistrationForm(formData);`
`  if (validationError) {`
`    throw new Error(validationError);`
`  }`

`  const user = formatNewUser(formData);`

`  saveUser(user);`
`  sendWelcomeEmail(user);`
`  logRegistration(user);`

`  return user;`
`}`

- I moved all the different responsibilities into new functions
- Added Guard-Clauses
- Threw errors (replaced console logs)
- Replaced all the magic numbers

### Large Classes (God Objects)

example found from: https://en.wikipedia.org/wiki/God_object

```
import std;

using std::string;
using std::vector;

class GameManager {
private:
    vector<string> players;
    int score = 0;
    bool running = false;
public:
    GameManager() = default;
    ~GameManager() = default;

    void addPlayer(const string& name) {
        players.push_back(name);
        std::println("Added player: {}", name);
    }

    void listPlayers() const {
        std::println("Players:");
        for (const string& p : players) {
            std::println(" - {}", p);
        }
    }

    void startGame() {
        running = true;
        score = 0;
        std::println("Game started!");
    }

    void updateGame() {
        if (running) {
            score += 10;
            std::println("Score updated: {}", score);
        }
    }

    void endGame() {
        running = false;
        std::println("Game over! Final score: {}", score);
    }

    void draw() {
        std::println("[Rendering Game Screen]");
    }

    void handleInput(const string& input) {
        if (input == "quit") {
            endGame();
        } else if (input == "score") {
            std::println("Current score: {}", score);
        } else {
            std::println("Unknown input");
        }
    }

    void saveGame() {
        std::println("Saving game state to disk...");
    }

    void loadGame() {
        std::println("Loading game state from disk...");
    }

    void run() {
        // ...
    }
};
```

Refactored code, from example as well:

```
import std;

using std::string;
using std::vector;

class PlayerManager {
private:
    vector<string> players;
public:
    PlayerManager() = default;
    ~PlayerManager() = default;

    void addPlayer(const string& name) {
        players.push_back(name);
        std::println("Added player: {}", name);
    }

    void listPlayers() const {
        std::println("Players:");
        for (const string& p : players) {
            std::println(" - {}", p);
        }
    }
};

class GameLogic {
private:
    int score = 0;
    bool running = false;
public:
    GameLogic() = default;
    ~GameLogic() = default;

    void startGame() {
        running = true;
        score = 0;
        std::println("Game started!");
    }

    void updateGame() {
        if (running) {
            score += 10;
            std::println("Score updated: {}", score);
        }
    }

    int getScore() const noexcept {
        return score;
    }

    void endGame() {
        running = false;
        std::println("Game over! Final score: {}", score);
    }
};

class Renderer {
public:
    Renderer() = default;
    ~Renderer() = default;

    void draw() {
        std::println("[Rendering Game Screen]");
    }
};

class InputHandler {
private:
    GameLogic& logic;
public:
    explicit InputHandler(GameLogic& logic):
        logic{logic} {}

    ~InputHandler() = default;

    void handleInput(const string& input) {
        if (input == "quit") {
            logic.endGame();
        } else if (input == "score") {
            std::println("Current score: {}", logic.getScore());
        } else {
            std::println("Unknown input");
        }
    }
};

class SaveSystem {
public:
    SaveSystem() = default;
    ~SaveSystem() = default;

    void saveGame() {
        std::println("Saving game state to disk...");
    }

    void loadGame() {
        std::println("Loading game state from disk...");
    }
};

class GameManager {
private:
    PlayerManager players;
    GameLogic logic;
    Renderer renderer;
    InputHandler input(logic);
    SaveSystem saves;
public:
    GameManager() = default;
    ~GameManager() = default;

    void run() {
        // ...
    }
};
```

### Deeply Nested Conditionals

example from Google's Gemini search result:

```
function processOrder(user, cart) {
    // Level 1: Check if user is logged in
    if (user.isLoggedIn) {

        // Level 2: Check if cart has items
        if (cart.items.length > 0) {

            // Level 3: Check if inventory is available
            if (checkInventory(cart.items)) {

                // Level 4: Check if payment details are valid
                if (user.hasValidPayment) {
                    executePurchase(user, cart);
                    console.log("Order processed successfully!");
                } else {
                    console.log("Error: Invalid payment details.");
                }

            } else {
                console.log("Error: Some items are out of stock.");
            }

        } else {
            console.log("Error: Cart is empty.");
        }

    } else {
        console.log("Error: User must be logged in.");
    }
}
```

From Reddit, this is the refactored code I found which implements guards:

```
function processOrder(user, cart) {
    // Guard Clauses: Handle errors immediately and exit
    if (!user.isLoggedIn) return console.log("Error: User must be logged in.");
    if (cart.items.length === 0) return console.log("Error: Cart is empty.");
    if (!checkInventory(cart.items)) return console.log("Error: Some items are out of stock.");
    if (!user.hasValidPayment) return console.log("Error: Invalid payment details.");

    // The main logic stays flat, clean, and easy to read
    executePurchase(user, cart);
    console.log("Order processed successfully!");
}
```

### Commented-Out Code

This one was straightforward, as it is dead code and it just needs to be deleted.

### Inconsistent Naming

This blog showcased the bad example and the refactored example:

```
// Bad: Multiple naming styles in one class
class UserService {
  getUserData() { }      // camelCase
  get_user_permissions() { }  // snake_case
  GetUserRoles() { }     // PascalCase
  fetch_user_profile() { }    // snake_case again
}

// Good: Consistent naming
class UserService {
  getUserData() { }
  getUserPermissions() { }
  getUserRoles() { }
  fetchUserProfile() { }
}
```

## What code smells did you find in your code?

I didn't find many because it was a simply math file. However, I did notice I did not implement a guard clause for the division function, which I rectified by adding a value error. In the broader scope of things, I find when I develop in my student teams, we often have issues with long functions and inconsistent naming. When we add new functionality, laziness can seep in, and paired with lack of planning we end with these bloated functions that take several hundred lines of code. Same with inconsistent naming, sometimes different teammates prefer other naming conventions, and don't realise they are different from what majority of the team uses.

## How did refactoring improve the readability and maintainability of the code?

Naming improves the readability, consistent and clear naming helps you follow what the code is doing. Extracted functions also enhance both readability and maintainability because it separates the responsibilities so you can isolate different issues or behaviours.

## How can avoiding code smells make future debugging easier?

- Clear naming helps with reading and understanding the code
- No duplicated logic means there are not duplicated bugs
- Bugs are easier to isolate because of the lack of god objects, long functions and there are informational errors
- Error handling, guard clauses and explicit returns narrow down where a bug could exist

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
