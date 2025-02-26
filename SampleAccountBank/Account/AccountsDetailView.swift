//
//  AccountsDetailView.swift
//  SampleAccountBank
//
//  Created by Teryl S on 2/26/25.
//

import SwiftUI

struct AccountsDetailView: View {
    let account: Account
    let transactions: [Transaction]
    
    var body: some View {
        List(transactions) { transaction in
            HStack {
                Text("\(transaction.date, style: .date)")
                Spacer()
                Text("$\(transaction.amount, specifier: "%.2f")")
            }
        }
        .navigationBarTitle("\(account.name)")
    }
}

#Preview {
    AccountsDetailView(account: Account(name: "Checking", isFavorite: true), transactions: [])
}
