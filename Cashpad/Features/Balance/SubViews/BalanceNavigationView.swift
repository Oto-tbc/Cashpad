//
//  BalanceNavigationView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 16.01.26.
//

import UIKit

final class BalanceNavigationView: UIView {

    // MARK: - UI

    private let stack = UIStackView()
    private let titleLabel = UILabel()
    private let backButton = UIButton()

    private let arrowLeft = UIImage(
        systemName: "arrow.left",
        withConfiguration: UIImage.SymbolConfiguration(
            pointSize: 18,
            weight: .semibold
        )
    )

    // MARK: - Actions

    var onBack: (() -> Void)?

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setup() {
        backgroundColor = UIColor(named: "Background")

        stack.axis = .horizontal
        stack.spacing = 34
        stack.alignment = .center

        addSubview(stack)
        stack.addArrangedSubview(backButton)
        stack.addArrangedSubview(titleLabel)

        backButton.configuration = .glass()
        backButton.layer.cornerRadius = 24
        backButton.setImage(arrowLeft, for: .normal)
        backButton.tintColor = .label

        backButton.addAction(
            UIAction { [weak self] _ in
                self?.onBack?()
            },
            for: .touchUpInside
        )

        titleLabel.font = .systemFont(ofSize: 26, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 1
        titleLabel.setContentCompressionResistancePriority(.required, for: .horizontal)

        stack.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 24),
            stack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -24),

            backButton.widthAnchor.constraint(equalToConstant: 48),
            backButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }

    // MARK: - Coinfig

    func configure(title: String) {
        titleLabel.text = title
    }
}
