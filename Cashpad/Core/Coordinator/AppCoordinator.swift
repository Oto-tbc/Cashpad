//
//  AppCoordinator.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit

final class AppCoordinator: Coordinator {

    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let accountsCoordinator = AccountsCoordinator(
            navigationController: navigationController
        )
        accountsCoordinator.start()
    }
}
