//
//  AccountsView.swift
//  SampleAccountBank
//
//  Created by Teryl S on 2/25/25.
//

import SwiftUI

struct AccountsView: View {
    @StateObject var accountsProvider = AccountProvider()
    
    var body: some View {
        NavigationStack {
            List(accountsProvider.accounts.filter({ $0.isFavorite })) { account in
                NavigationLink(destination: AccountsDetailView(account: account, transactions: accountsProvider.getMostRecentTransactions(account: account, amount: 15)), label: {
                    VStack(alignment: .leading) {
                        Text(account.name).bold()
                        ForEach(accountsProvider.getMostRecentTransactions(account: account, amount: 3)) { transaction in
                                HStack {
                                    Spacer()
                                    Text("$\(transaction.amount, specifier: "%.2f")")
                                    Text("\(transaction.date, style: .date)")
                            }
                        }
                    }
                })
            }
            .navigationBarTitle("Accounts")
            .toolbar {
                NavigationLink(destination: AccountsFavoriteView(accountsProvider: accountsProvider), label: {
                    Text("Favorite Accounts")
                })
            }
        }
    }
    

}

#Preview {
    AccountsView()
}
