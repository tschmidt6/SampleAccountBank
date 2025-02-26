//
//  AccountsProvider.swift
//  SampleAccountBank
//
//  Created by Teryl S on 2/25/25.
//

import Foundation
import SwiftUI

/// Represents an account with a unique identifier, name, and favorite status.
struct Account: Identifiable, Hashable {
    /// A unique identifier for the account.
    let id = UUID()
    
    /// The name of the account
    let name: String
    
    /// Indicates whether the account is favorited
    var isFavorite: Bool
}

/// Represents a financial transaction associated with an account.
struct Transaction: Identifiable {
    /// A unique identifier for the transaction.
    let id = UUID()
    
    /// The unique identifier of the associated account.
    let accountID: UUID
    
    /// The monetary value of the transaction.
    let amount: Double
    
    /// The timestamp of when the transaction occurred.
    let date: Date
}

/// A mock provider for managing accounts and their transactions.
class AccountProvider: ObservableObject {
    /// A Published array of accounts to notify subscribers of changes
    @Published var accounts: [Account] = []
    
    /// An array of transactions associated with the accounts
    var transaction: [Transaction] = []
    
    
    init() {
        self.accounts = makeAccounts()
        self.transaction = makeTransactions(accounts: self.accounts)
    }
    
    /// Generates a random list of accounts.
    /// - Returns: An array of `Account` objects with random properties.
    func makeAccounts() -> [Account] {
        var accounts: [Account] = []
        let accountCount = Int.random(in: 1...10)
        let accountTypes = ["Checking", "Savings", "Investment"]
        for i in 0..<accountCount {
            let isFavorite = Int.random(in: 0...1) == 0 ? true : false
            let account = Account(name: "\(accountTypes[Int.random(in: 0...2)]) \(i)",
                                  isFavorite: isFavorite)
            accounts.append(account)
        }
        return accounts
    }
    
    /// Generates a random number of transactions (between 0 and 20) for a given account.
    /// - Parameter accounts: The list of accounts for which transactions will be created.
    /// - Returns: An array of `Transaction` objects with random properties.
    func makeTransactions(accounts: [Account]) -> [Transaction] {
        var transactions: [Transaction] = []
        var transactionCount = Int.random(in: 0...20)
        for account in accounts {
            for _ in 0..<transactionCount {
                let transaction = Transaction(accountID: account.id,
                                              amount: Double.random(in: 0...10000000),
                                              date: Date(timeIntervalSince1970: TimeInterval(Int32.random(in: 0...Int32.max))))
                transactions.append(transaction)
            }
            transactionCount = Int.random(in: 0...20) // Each account has a different number of transactions
        }
        return transactions
    }
    
    /// Gets the most X recent transactions for an account, where x is specified by the amount parameter
    func getMostRecentTransactions(account: Account, amount: Int) -> [Transaction] {
        // get transactions that are associated with the account
        let accountTransactions = transaction.filter({ $0.accountID == account.id })
        
        // Sort the transactions so we get the most recent ones
        let sortedTransactions = accountTransactions.sorted(by: { $0.date > $1.date })
        
        // Get the X most recent transactions
        let mostRecentTransactions = sortedTransactions.prefix(amount)
        
        return Array(mostRecentTransactions)
    }
    
    /// Updates the specified account to switch the isFavorite variable
    func updateFavoriteAccount(account: Account) {
        // get the account specified
        guard let index = accounts.firstIndex(of: account) else { return }
        // Switch the isFavorite variable
        accounts[index].isFavorite.toggle()
    }
}
