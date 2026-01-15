//
//  BalanceViewModel.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 14.01.26.
//

import Foundation

final class BalanceViewModel {

    private let accountId: UUID
    private let transactionRepository: TransactionRepositoryProtocol

    private(set) var transactions: [Transaction] = [] {
        didSet {
            onTransactionsChanged?(transactions)
        }
    }

    var onTransactionsChanged: (([Transaction]) -> Void)?

    init(
        accountId: UUID,
        transactionRepository: TransactionRepositoryProtocol
    ) {
        self.accountId = accountId
        self.transactionRepository = transactionRepository
    }

    func loadTransactions() {
        do {
            transactions = try transactionRepository
                .fetchTransactions(accountId: accountId)
        } catch {
            print("Failed to fetch transactions:", error)
        }
    }
}
