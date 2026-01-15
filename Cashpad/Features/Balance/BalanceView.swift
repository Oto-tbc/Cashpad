//
//  BalanceView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 15.01.26.
//

import UIKit

final class BalanceView: UIView {

    // MARK: - UI

    private let titleLabel = UILabel()
    private let balanceLabel = UILabel()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupView() {
        backgroundColor = .systemGroupedBackground

        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .secondaryLabel

        balanceLabel.font = .systemFont(ofSize: 32, weight: .bold)
        balanceLabel.textColor = .label
    }

    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(balanceLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            balanceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            balanceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor)
        ])
    }

    // MARK: - Bind

    func configure(account: AccountModel) {
        titleLabel.text = account.name
        balanceLabel.text = "\(account.balance) \(account.currency)"
    }
}
