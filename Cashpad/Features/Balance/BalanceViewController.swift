//
//  BalanceViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit
import SwiftUI
import Combine

final class BalanceViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    private let account: AccountModel
    private let viewModel: BalanceViewModel
    private var cancellables = Set<AnyCancellable>()
    
    private let contentView = BalanceView()
    
    private let onBack: () -> Void
    
    // MARK: - Initializers
    init(
        account: AccountModel,
        viewModel: BalanceViewModel,
        onBack: @escaping () -> Void
    ) {
        self.account = account
        self.viewModel = viewModel
        self.onBack = onBack
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    // Setup UI, bindings, and initial data loading
    override func viewDidLoad() {
        super.viewDidLoad()
        title = account.name
        view.backgroundColor = UIColor(named: "SecondaryBackground")
        contentView.configure(
            account: account,
            onBack: onBack
        )
        setupTransactionsView()
        viewModel.loadTransactions()
        bindViewModel()
    }
    
    // Enable interactive pop gesture when view appears
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    // Clean up gesture recognizer delegation
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    // Allow interactive pop only when there is more than one VC in the stack
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
    
    // MARK: - SwiftUI Embedding
    // Embeds TransactionsView (SwiftUI) into UIKit using UIHostingController
    private func setupTransactionsView() {
        let transactionsView = TransactionsView(viewModel: viewModel)
        let hostingController = UIHostingController(rootView: transactionsView)

        addChild(hostingController)
        view.addSubview(hostingController.view)

        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        hostingController.view.backgroundColor = .clear

        NSLayoutConstraint.activate([
            hostingController.view.heightAnchor.constraint(equalToConstant: 400),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hostingController.didMove(toParent: self)
    }
    
    // MARK: - Bindings
    // Bind Combine publishers to update UI
    private func bindViewModel() {
        
        viewModel.$transactions
            .receive(on: DispatchQueue.main)
            .sink { [weak self] transactions in
                guard let self else { return }
                
                self.updateBalance(from: transactions)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - UI Updates
    // Calculates and displays the account balance
    private func updateBalance(from transactions: [Transaction]) {
        let balance = transactions.reduce(0) { $0 + $1.amount }
        
        let currency = Currency(rawValue: account.currency) ?? .usd
        
        contentView.updateBalance(
            balance: balance,
            currency: currency.symbol
        )
    }
}
