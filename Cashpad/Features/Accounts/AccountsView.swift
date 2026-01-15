//
//  AccountsViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import SwiftUI

struct AccountsView: View {

    @ObservedObject var viewModel: AccountsViewModel

    @State private var showSettings = false
    @State private var showAnalytics = false
    @State private var showAddAccountSheet = false

    @Namespace private var modalAnimation

    let onAccountSelected: (AccountModel) -> Void

    var body: some View {

        ZStack(alignment: .bottomTrailing) {

            VStack {

                AccountsNavigationBarView(
                    showSettings: $showSettings,
                    showAnalytics: $showAnalytics,
                    animation: modalAnimation
                )

                AccountsCardsListView(
                    viewModel: viewModel,
                    onAccountSelected: onAccountSelected
                )

            }
            .frame(maxWidth: .infinity)
            .blur(radius: showSettings || showAnalytics ? 8 : 0)
            .allowsHitTesting(!(showSettings || showAnalytics))

            AddButtonView(onAction: { showAddAccountSheet = true })

            if showSettings {
                SettingsModalView(
                    showSettings: $showSettings,
                    animation: modalAnimation
                )
            } else if showAnalytics {
                AnalyticsModalView(
                    showAnalytics: $showAnalytics,
                    animation: modalAnimation
                )
            }
        }
        .onAppear {
            viewModel.loadAccounts()
        }
        .animation(
            .spring(response: 0.45, dampingFraction: 0.85),
            value: showSettings || showAnalytics
        )
        .background(Color("SecondaryBackground"))
        .sheet(isPresented: $showAddAccountSheet) {
            AddAccountSheet(
                onSave: { name, currency, emoji, color, initialBalance in
                    viewModel.addAccount(
                        name: name,
                        currency: currency,
                        emoji: emoji,
                        color: color,
                        initialBalance: initialBalance
                    )
                    showAddAccountSheet = false
                },
                onCancel: {
                    showAddAccountSheet = false
                }
            )
            .presentationDetents([.fraction(0.95)])
            .presentationDragIndicator(.visible)
        }
    }
}
