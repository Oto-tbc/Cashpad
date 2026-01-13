//
//  AccountListHelpers.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 13.01.26.
//

import SwiftUI

extension AccountsCardsListView {

    var totalBalanceString: String {
        let total = viewModel.accounts.reduce(0) { $0 + $1.balance }
        return String(format: "%.2f", total)
    }

    func formattedBalance(for account: AccountModel) -> String {
        String(format: "%.2f", account.balance)
    }
    
}
