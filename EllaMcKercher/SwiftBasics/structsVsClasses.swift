//
//  structsVsClasses.swift
//  


import Foundation

struct Dimension {
    var squareFeet: Int
    var stories: Int
}

struct Feature {
    var bedrooms: Int
    var baths: Int
    var garage: Bool
}

class Dwelling {
    var dimensions = Dimension()
    var features = Feature()
    var address: String
    var price: Int
    
    init(dimensions: Dimension, features: Feature, address: String, price: Int) {
        self.dimensions = Dimension
        self.features = Feature
        self.address = address
        self.price = price
    }
}

// Create class instance
var exampleHouse = Dwelling(dimensions: Dimension(squareFeet: 2590, stories: 3), features: Feature(bedrooms: 4, baths: 3, garage: true), address: "123 Fake Street", price: 1000000)

var dimensions1 = Dimension(squareFeet: 1000, stories: 1)
var dimensions2 = dimensions1 // this creates a duplicate, unaffected copy of dimension1

// update dimensions1 sq feet
dimensions1.squareFeet = 3000

// show how the second dimensions doesn't update
print("dimensions1 square feet is \(dimensions1.squareFeet)")
print("dimensions2 square feet is \(dimensions2.squareFeet)")

// now make another reference to the example house
var duplicateExampleHouse = exampleHouse

// update the street name
exampleHouse.address = "123 REAL Avenue"

print("exampleHouse street is \(exampleHouse.address)")
print("duplicateExampleHouse street is \(duplicateExampleHouse.address)")

// now show that classes can enable inheritance

class Apartment: Dwelling {
    var floorNumber: Int
    var balcony: Bool
    
    init(dimensions: Dimension, features: Feature, address: String, price: Int, floorNumber: Int, balcony: Bool) {
        self.floorNumber = floorNumber
        self.balcony = balcony
        super.init(dimensions: Dimension, features: Feature, address: address, price: price)
    }
}
