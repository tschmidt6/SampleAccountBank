//
//  AccountsView.swift
//  SampleAccountBank
//
//  Created by Teryl S on 2/25/25.
//

import SwiftUI

struct AccountsView: View {
    let accountProvider = AccountProvider()
    
    var body: some View {
        NavigationStack {
            List(accountProvider.accounts) { account in
                VStack(alignment: .leading) {
                    Text(account.name).bold()
                    ForEach(getMostRecentTransactions(account: account, transactions: accountProvider.transaction)) { transaction in
                        HStack {
                            Spacer()
                            Text("$\(transaction.amount, specifier: "%.2f")")
                            Text("\(transaction.date, style: .date)")
                        }
                    }
                }
            }
            .navigationBarTitle("Accounts")
        }
    }
    
    func getMostRecentTransactions(account: Account, transactions: [Transaction]) -> [Transaction] {
        // get transactions that are associated with the account
        let accountTransactions = transactions.filter({ $0.accountID == account.id })
        
        // Sort the transactions so we get the most recent ones
        let sortedTransactions = accountTransactions.sorted(by: { $0.date > $1.date })
        
        // Get the 3 most recent transactions
        let mostRecentTransactions = sortedTransactions.prefix(3)
        
        return Array(mostRecentTransactions)
    }
}

#Preview {
    AccountsView()
}
