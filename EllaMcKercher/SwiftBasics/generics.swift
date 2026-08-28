//
//  generics.swift
//  
//
//  Created by Ella McKercher on 2026-08-28.
//

import Foundation

// Generics let you write functions or types that can use any type

func areEqual<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}

print(areEqual(a: 5, b: 6))

// This generic has to conform to Comparable protocol
func findLargest<T: Comparable>(items: [T]) -> T {
    var largest = items[0]
    for item in items {
        if item > largest {
            largest = item
        }
    }
    return largest
}
