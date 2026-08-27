//
//  protocols.swift
//  
//
//  Created by Ella McKercher on 2026-08-28.
//

import Foundation

enum TypeOfDwelling {
    case house
    case apartment
    case condo
    case houseboat
    case trailer
}

// Protocols define a list of methods that a type must have (without implementing them itself)
protocol Sellable {
    var type: TypeOfDwelling { get }
    var price: Double { get }
    func sell()
}

struct House: Sellable {
    var type: TypeOfDwelling
    var price: Double
    
    init(type: TypeOfDwelling, price: Double) {
        self.type = type
        self.price = price
    }
    
    func sell() {
        print("This \(type) is for sale for \(price)")
    }
}

let myHouse = House(type: .house, price: 750000) // Can write .type since it knows the myHouse.type needs to be of TypeDwelling already
myHouse.sell()

func listProperty(item: Sellable) {
    item.sell()
}

listProperty(item: myHouse)

// Extensions let you add functionality after the fact of creating a type
extension House {
    func increasePrice(amountIncrease: Double) -> Double {
        return price + amountIncrease
    }
}

print("my house is now selling for \(myHouse.increasePrice(amountIncrease: 2500)) dollars")

