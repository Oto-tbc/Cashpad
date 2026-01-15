//
//  AccountsCoordinator.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import CoreData
import SwiftUI
import UIKit

final class AccountsCoordinator: Coordinator {

    var navigationController: UINavigationController
    private let diContainer: AppDIContainer

    init(
        navigationController: UINavigationController,
        diContainer: AppDIContainer = .shared
    ) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }

    func start() {

        let viewModel = diContainer.makeAccountsViewModel()

        let accountsView = AccountsView(
            viewModel: viewModel,
            onAccountSelected: { [weak self] account in
                print("Account tapped")
                self?.showBalance(for: account)
            }
        )

        let hostingVC = UIHostingController(rootView: accountsView)
        navigationController.setViewControllers([hostingVC], animated: false)
    }

    private func showBalance(for account: AccountModel) {
        print("NAV VC:", navigationController)
        print("TOP VC:", navigationController.topViewController as Any)
        
        let coordinator = BalanceCoordinator(
            navigationController: navigationController,
            account: account
        )
        coordinator.start()
    }
}
