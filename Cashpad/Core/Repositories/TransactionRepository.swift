//
//  TransactionRepositoryProtocol.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 14.01.26.
//


import CoreData

protocol TransactionRepositoryProtocol {

    func fetchTransactions(
        accountId: UUID
    ) throws -> [Transaction]

    func createTransaction(
        account: Account,
        amount: Double,
        type: Int
    ) throws -> Transaction

    func deleteTransaction(
        _ transaction: Transaction
    ) throws
}

final class TransactionRepository: TransactionRepositoryProtocol {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func fetchTransactions(
        accountId: UUID
    ) throws -> [Transaction] {

        let request: NSFetchRequest<Transaction> = Transaction.fetchRequest()

        request.predicate = NSPredicate(
            format: "account.id == %@",
            accountId as CVarArg
        )

        request.sortDescriptors = [
            NSSortDescriptor(key: "date", ascending: false)
        ]

        return try context.fetch(request)
    }

    func createTransaction(
        account: Account,
        amount: Double,
        type: Int
    ) throws -> Transaction {

        let transaction = Transaction(context: context)
        transaction.id = UUID()
        transaction.amount = amount
        transaction.date = Date()
        transaction.type = Int16(type)
        transaction.account = account

        try context.save()
        return transaction
    }

    func deleteTransaction(
        _ transaction: Transaction
    ) throws {
        context.delete(transaction)
        try context.save()
    }
}
