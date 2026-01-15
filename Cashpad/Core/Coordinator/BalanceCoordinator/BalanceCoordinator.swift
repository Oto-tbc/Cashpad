//
//  BalanceCoordinator.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit

final class BalanceCoordinator: Coordinator {
    
    private let diContainer: AppDIContainer

    var navigationController: UINavigationController
    let account: AccountModel

    init(
        navigationController: UINavigationController,
        account: AccountModel,
        diContainer: AppDIContainer = .shared
    ) {
        self.navigationController = navigationController
        self.account = account
        self.diContainer = diContainer
    }

    func start() {
        let viewModel = diContainer.makeBalanceViewModel(accountId: account.id)
        let vc = BalanceViewController(
            account: account,
            viewModel: viewModel
        )
        navigationController.pushViewController(vc, animated: true)
    }}
