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
