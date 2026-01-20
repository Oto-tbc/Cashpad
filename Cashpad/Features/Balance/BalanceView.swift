//
//  BalanceView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 15.01.26.
//

import UIKit

final class BalanceView: UIView {

    private let navigationView = BalanceNavigationView()
    private let balanceView = CurrentBalanceView()

    private var onBack: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        addSubview(navigationView)
        addSubview(balanceView)

        navigationView.translatesAutoresizingMaskIntoConstraints = false
        balanceView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            navigationView.topAnchor.constraint(equalTo: topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 190),
            
            balanceView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            balanceView.leadingAnchor.constraint(equalTo: leadingAnchor),
            balanceView.trailingAnchor.constraint(equalTo: trailingAnchor),
            balanceView.heightAnchor.constraint(equalToConstant: 130)
        ])
    }

    func configure(
        account: AccountModel,
        onBack: @escaping () -> Void
    ) {
        navigationView.configure(title: account.name)
        navigationView.onBack = onBack
    }
    
    func updateBalance(
        balance: Double,
        currency: String
    ) {
        balanceView.configure(
            balance: balance,
            currency: currency
        )
    }
    
}
