//
//  AccountsCoordinator.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit
import SwiftUI

final class AccountsCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {

        let accounts = [
            Account(id: .init(), name: "Main", type: .personal),
            Account(id: .init(), name: "Business EU", type: .business),
        ]

        let accountsView = AccountsView(
            accounts: accounts,
            onAccountSelected: { [weak self] account in
                self?.showBalance(for: account)
            }
        )

        let hostingVC = UIHostingController(rootView: accountsView)
        navigationController.setViewControllers([hostingVC], animated: false)
    }

    private func showBalance(for account: Account) {
        let coordinator = BalanceCoordinator(
            navigationController: navigationController,
            account: account
        )
        coordinator.start()
    }
}
