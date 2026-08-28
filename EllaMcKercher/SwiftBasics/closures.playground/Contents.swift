import Cocoa

// Closures are a self-contained block of code. A function is just a named closure.
// (Int, Int) -> Int so the closure accepts two Ints as parameters and expects a returned Int
// a, b are the parameter names, in is a separator that indicates the next statment is the code
let practiceClosure: (Int, Int) -> Int = { a, b in
    return a + b
}

// This is the function equivalent
func practiceFunction(a: Int, b: Int) -> Int {
    return a + b
}

// map transforms every element in a collection into something new
// It does NOT affect the original collection
let numbers = [1, 2, 3, 4, 5]

let tripled = numbers.map { number in
    return number * 3
}

// Equivalent shorthand would be:
let doubled = numbers.map { $0 * 2} // $0 means "whatever first thing passed in is

// $1 would be "whatever second thing passed in is"

print(numbers)
print(tripled)
print(doubled)

// filter checks every element against a condition, and only the elements where the condition is true is added to the new collection
let evenNumbers = numbers.filter { number in
    return number % 2 == 0
}

// Shorthand: let evenNumbers2 = numbers.filter { $0 % 2 == 0 }

print(evenNumbers)

// Combining map and filter:
let doubledEvens = numbers.filter { $0 % 2 == 0 }.map { $0 * 2 }

print(doubledEvens)

// reduce combines every elemet in a collection into a single value
let sum = numbers.reduce(0) { $0 + $1 } // 0 is the initial value
// { $0 + $1 } means add the result + the next element (0 + 1), (1 + 2), etc.

print(sum)

let doubledEvensSum = numbers.filter { $0 % 2 == 0 }.map { $0 * 2 }.reduce(0) { $0 + $1}

print("Doubled Evens Sum: \(doubledEvensSum)")


