//
//  BalanceViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit

final class BalanceViewController: UIViewController {

    private let account: AccountModel
    private let viewModel: BalanceViewModel
    
    private let contentView = BalanceView()

    init(
        account: AccountModel,
        viewModel: BalanceViewModel
    ) {
        self.account = account
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = account.name
        contentView.configure(account: account)
    }
}
