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
