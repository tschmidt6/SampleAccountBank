//
//  AccountsFavoriteView.swift
//  SampleAccountBank
//
//  Created by Teryl S on 2/26/25.
//

import SwiftUI

struct AccountsFavoriteView: View {
    @ObservedObject var accountsProvider: AccountProvider
    
    var body: some View {
        List {
            ForEach(accountsProvider.accounts) { account in
                HStack {
                    Text(account.name)
                    Spacer()
                    if account.isFavorite {
                        Image(systemName: "heart.fill")
                    } else {
                        Image(systemName: "heart")
                    }
                }.onTapGesture {
                    accountsProvider.updateFavoriteAccount(account: account)
                }
            }
        }.navigationBarTitle("Accounts")
    }
}

#Preview {
    AccountsFavoriteView(accountsProvider: AccountProvider())
}
