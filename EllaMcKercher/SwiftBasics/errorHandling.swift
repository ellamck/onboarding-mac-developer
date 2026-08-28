//
//  errorHandling.swift
//  
//
//  Created by Ella McKercher on 2026-08-28.
//

import Foundation

enum BankAccountError: Error {
    case insufficentFunds
    case invalidAmount
    case accountNotFound
    case accountLocked
}

let bankAccountId: Int = 12345

func withdraw(accountNumber: Int, amount: Double, balance: Double, isLocked: Bool) throws {
    if isLocked {
        throw BankAccountError.accountLocked
    }
    if amount > balance {
        throw BankAccountError.insufficentFunds
    }
    if amount <= 0 {
        throw BankAccountError.invalidAmount
    }
    if accountNumber != bankAccountId {
        throw BankAccountError.accountNotFound
    }
    print("Withdrawal Successful!")
}

do {
    try withdraw(accountNumber: 1234, amount: 20, balance: 500, isLocked: false)
} catch {
    print("Unexpected error: \(error).")
}
