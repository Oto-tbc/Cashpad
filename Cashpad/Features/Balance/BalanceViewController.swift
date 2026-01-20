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
    
    private let balanceView = BalanceView()
    private var chartHostingController: UIHostingController<ChartView>?
    private var transactionsHostingController: UIHostingController<TransactionsView>?
    
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
        
    // Setup UI, bindings, and initial data loading
    override func viewDidLoad() {
        super.viewDidLoad()
        title = account.name
        view.backgroundColor = UIColor(named: "SecondaryBackground")
        balanceView.configure(
            account: account,
            onBack: onBack
        )
        setupBalanceView()
        setupChart()
        setupTransactionsView()
        bindViewModel()
        viewModel.loadTransactions()
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
    
    private func setupBalanceView() {
        view.addSubview(balanceView)
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: view.topAnchor),
            balanceView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            balanceView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            balanceView.heightAnchor.constraint(equalToConstant: 160)
        ])
    }
    
    private func setupChart() {
        // Build ChartViewModel via DI using the selected account id
        let chartVM = AppDIContainer.shared.makeChartViewModel(accountId: account.id)
        let chartView = ChartView(viewModel: chartVM)
        let hosting = UIHostingController(rootView: chartView)
        chartHostingController = hosting

        addChild(hosting)
        view.addSubview(hosting.view)

        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear

        // Place chart below balanceView
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: balanceView.bottomAnchor),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hosting.view.heightAnchor.constraint(equalToConstant: 240)
        ])

        hosting.didMove(toParent: self)
    }
    
    // Embeds TransactionsView (SwiftUI) into UIKit using UIHostingController
    private func setupTransactionsView() {
        let transactionsView = TransactionsView(viewModel: viewModel)
        let hosting = UIHostingController(rootView: transactionsView)
        transactionsHostingController = hosting

        addChild(hosting)
        view.addSubview(hosting.view)

        hosting.view.translatesAutoresizingMaskIntoConstraints = false
        hosting.view.backgroundColor = .clear

        guard let chartView = chartHostingController?.view else { return }

        // Pin transactions view below chart and stretch to bottom
        NSLayoutConstraint.activate([
            hosting.view.topAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 12),
            hosting.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hosting.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        hosting.didMove(toParent: self)
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
        let balance = transactions.reduce(0) { result, transaction in
            transaction.type == 0
                ? result + transaction.amount
                : result - transaction.amount
        }
        
        let currency = Currency(rawValue: account.currency) ?? .usd
        
        balanceView.updateBalance(
            balance: balance,
            currency: currency.symbol
        )
    }
}
