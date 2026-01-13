//
//  AccountsCardsListView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 11.01.26.
//


import SwiftUI

struct AccountsCardsListView: View {

    @ObservedObject var viewModel: AccountsViewModel
    let onAccountSelected: (AccountModel) -> Void

    var body: some View {

        ScrollView {
            VStack(spacing: 16) {

                let totalCurrency = Currency(
                    rawValue: viewModel.accounts.first?.currency ?? ""
                ) ?? .usd

                TotalAccountsBalanceView(
                    currency: totalCurrency.symbol,
                    balance: totalBalanceString,
                    trend: .same
                )

                VStack(spacing: 12) {
                    ForEach(viewModel.accounts) { account in

                        let currency = Currency(
                            rawValue: account.currency
                        ) ?? .usd

                        AccountsCardsView(
                            accountName: account.name,
                            currency: currency.symbol,
                            balance: formattedBalance(for: account),
                            trend: .same,
                            onDelete: {
                                if let index = viewModel.accounts.firstIndex(where: { $0.id == account.id }) {
                                    viewModel.deleteAccount(at: index)
                                }
                            }
                        )
                        .onTapGesture {
                            onAccountSelected(account)
                        }
                    }
                }
            }
            .padding(16)
        }
    }

    // MARK: - Helpers

    private var totalBalanceString: String {
        let total = viewModel.accounts.reduce(0) { $0 + $1.balance }
        return String(format: "%.2f", total)
    }

    private func formattedBalance(for account: AccountModel) -> String {
        String(format: "%.2f", account.balance)
    }
}

