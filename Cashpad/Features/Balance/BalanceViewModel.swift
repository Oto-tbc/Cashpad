//
//  BalanceViewModel.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 14.01.26.
//

import Foundation
import Combine

@MainActor
final class BalanceViewModel: ObservableObject {

    // MARK: - Dependencies
    private let accountId: UUID
    private let transactionRepository: TransactionRepositoryProtocol
    private let accountRepository: AccountRepositoryProtocol

    // MARK: - Published State
    @Published private(set) var transactions: [Transaction] = []
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var balance: Double = 0
    @Published private(set) var currencySymbol: String = ""
    @Published var error: Error?

    // MARK: - Init (DI-friendly)
    init(
        accountId: UUID,
        transactionRepository: TransactionRepositoryProtocol,
        accountRepository: AccountRepositoryProtocol
    ) {
        self.accountId = accountId
        self.transactionRepository = transactionRepository
        self.accountRepository = accountRepository
    }

    // MARK: - Load
    func loadTransactions() {
        isLoading = true
        error = nil

        do {
            transactions = try transactionRepository.fetchTransactions(
                accountId: accountId
            )
            recomputeBalance()
        } catch {
            self.error = error
        }

        isLoading = false
    }

    private func recomputeBalance() {
        let newBalance = transactions.reduce(0.0) { result, transaction in
            result + transaction.amount
        }
        balance = newBalance

        do {
            let account = try accountRepository.fetchAccount(by: accountId)
            let currency = Currency(rawValue: account.currency ?? "") ?? .usd
            currencySymbol = currency.symbol
        } catch {
            // Fallback to USD symbol on failure
            currencySymbol = Currency.usd.symbol
        }
    }

    // MARK: - Add
    func addTransaction(
        amount: Double,
        date: Date,
        note: String?,
        type: TransactionType
    ) {
        do {
            let account = try accountRepository.fetchAccount(by: accountId)

            _ = try transactionRepository.createTransaction(
                account: account,
                amount: amount,
                date: date,
                note: note,
                type: type
            )

            loadTransactions()
        } catch {
            self.error = error
        }
    }

    // MARK: - Delete
    func deleteTransaction(_ transaction: Transaction) {
        do {
            try transactionRepository.deleteTransaction(transaction)
            transactions.removeAll { $0.id == transaction.id }
            recomputeBalance()
        } catch {
            self.error = error
        }
    }
}
