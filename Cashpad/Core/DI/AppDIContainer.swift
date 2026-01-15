//
//  AppDIContainer.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 12.01.26.
//


import CoreData

final class AppDIContainer {

    static let shared = AppDIContainer()

    private let persistenceController: PersistenceController

    private init() {
        self.persistenceController = PersistenceController.shared
    }

    // MARK: - Repositories

    func makeAccountRepository() -> AccountRepositoryProtocol {
        AccountRepository(
            context: persistenceController.container.viewContext
        )
    }
    
    func makeTransactionRepository() -> TransactionRepositoryProtocol {
        TransactionRepository(
            context: persistenceController.container.viewContext
        )
    }

    // MARK: - ViewModels

    func makeAccountsViewModel() -> AccountsViewModel {
        AccountsViewModel(
            repository: makeAccountRepository()
        )
    }
    
    func makeBalanceViewModel(accountId: UUID) -> BalanceViewModel {
        BalanceViewModel(
            accountId: accountId,
            transactionRepository: makeTransactionRepository()
        )
    }
}
