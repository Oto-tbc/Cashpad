//
//  AccountsViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import SwiftUI

struct AccountsView: View {

    let accounts: [Account]
    let onAccountSelected: (Account) -> Void

    var body: some View {
        List(accounts, id: \.id) { account in
            Button {
                onAccountSelected(account)
            } label: {
                VStack(alignment: .leading) {
                    Text(account.name)
                        .font(.headline)
                    Text(verbatim: String(describing: account.type))
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
        .navigationTitle("Accounts")
    }
}

