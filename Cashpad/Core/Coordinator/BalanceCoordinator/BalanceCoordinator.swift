//
//  BalanceCoordinator.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit

final class BalanceCoordinator: Coordinator {

    var navigationController: UINavigationController
    let account: Account

    init(
        navigationController: UINavigationController,
        account: Account
    ) {
        self.navigationController = navigationController
        self.account = account
    }

    func start() {
        let vc = BalanceViewController(account: account)
        navigationController.pushViewController(vc, animated: true)
    }
}
