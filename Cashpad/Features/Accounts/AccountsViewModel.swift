//
//  AccuntsViewModel.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 12.01.26.
//

import Combine
import Foundation

@MainActor
final class AccountsViewModel: ObservableObject {
    
    
    @Published private(set) var accounts: [AccountModel] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorMessage: String?
    
    
    private let repository: AccountRepositoryProtocol

    
    init(repository: AccountRepositoryProtocol) {
        self.repository = repository
    }

    
    func loadAccounts() {
        isLoading = true
        errorMessage = nil

        do {
            let cdAccounts = try repository.fetchAccounts()
            accounts = cdAccounts.map { Self.mapToModel($0) }
        } catch {
            errorMessage = "Failed to load accounts"
        }

        isLoading = false
    }

    func addAccount(
        name: String,
        currency: String,
        emoji: String?,
        color: String?,
        initialBalance: Double
    ) {
        do {
            let account = try repository.createAccount(
                name: name,
                currency: currency,
                emoji: emoji,
                color: color
            )

            if initialBalance > 0 {
                try repository.addInitialTransaction(
                    to: account,
                    amount: initialBalance
                )
            }

            loadAccounts()
        } catch {
            errorMessage = "Failed to create account"
        }
    }

    func deleteAccount(at index: Int) {
        guard accounts.indices.contains(index) else { return }

        do {
            let cdAccounts = try repository.fetchAccounts()
            let accountToDelete = cdAccounts[index]
            try repository.deleteAccount(accountToDelete)
            loadAccounts()
        } catch {
            errorMessage = "Failed to delete account"
        }
    }

    
    private static func mapToModel(_ account: Account) -> AccountModel {
        let transactions = account.transactions as? Set<Transaction> ?? []

        let balance = transactions.reduce(0.0) { result, transaction in
            result + transaction.amount
        }

        return AccountModel(
            id: account.id ?? UUID(),
            name: account.name ?? "",
            currency: account.currency ?? "",
            emoji: account.emoji,
            color: account.color,
            createdAt: account.createdAt ?? Date(),
            balance: balance
        )
    }
}

