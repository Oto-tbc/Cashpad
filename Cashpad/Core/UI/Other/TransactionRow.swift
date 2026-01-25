//
//  TransactionRow.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 22.01.26.
//

import SwiftUI

struct TransactionRow: View {
    let transaction: Transaction
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill((transaction.type == 0) ? Color.green.opacity(0.2) : Color.red.opacity(0.2))
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: transaction.type == 0 ? "arrow.down.circle" : "arrow.up.circle")
                        .foregroundStyle(transaction.type == 0 ? .green : .red)
                )

            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.note ?? (transaction.type == 0 ? "Income" : "Expense"))
                    .font(.body)
                    .lineLimit(1)
                if let date = transaction.date {
                    Text(date.formatted(date: .omitted, time: .shortened))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }

            Spacer()

            Text(String(format: "%.2f", transaction.amount))
                .font(.headline)
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(.thinMaterial)
        )
    }
}
