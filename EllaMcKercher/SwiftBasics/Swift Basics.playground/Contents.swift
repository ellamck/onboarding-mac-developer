// Variables, Constants & Data Types Demo
import Foundation // Need for date

let timeCreated = Date() // Cannot change after being set
var lastModifiedAt = Date() // Can change after being set

let firstNameOfCreator: String = "Ella"
var middleNameOfCreator: String? = nil
let lastNameOfCreator: String = "McKercher"

let number: Int = 2
let isActive: Bool = true
let isStudent: Bool? = nil
let tuitionOwing: Float = 10000.00
var letter: Character = "A"

var studentNames: [String] = ["Ella", "Blake", "Harry"]
let studentId: Set<Int> = [123, 234, 345] // Cannot have duplicate student IDs
var studentIdDict: [Int: String] = [123: "Ella", 234: "Blake", 345: "Harry"]


for (id, name) in studentIdDict {
    print("Student Name: \(name) | Student ID: \(id)")
}

// Guard and If-Let Chaining

// Using an if-let for unwrapping an optional
func greetStudent(firstName: String, middleName: String?, lastName: String) {
    if let middle = middleName {
        print("Hello \(firstName) \(middle) \(lastName) nice to meet you!")
        return
    } else {
        print("Hello \(firstName) \(lastName) nice to meet you!")
    }
}

greetStudent(firstName: "Ella", middleName: nil, lastName: "McKercher")
greetStudent(firstName: "Ella", middleName: "Rose", lastName: "McKercher")

// Using a guard chaining
func checkStudentId(id: Int?, studentName: String) {
    guard let studentID = id else {
        print("All students must have an ID.")
        return
    }
    print("Welcome to university \(studentName) your student ID number is \(studentID)")
}

checkStudentId(id: nil, studentName: "Ella")
