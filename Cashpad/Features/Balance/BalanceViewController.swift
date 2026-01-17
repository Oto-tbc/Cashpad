//
//  BalanceViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import UIKit

final class BalanceViewController: UIViewController, UIGestureRecognizerDelegate {

    private let account: AccountModel
    private let viewModel: BalanceViewModel

    private let contentView = BalanceView()
    
    private let onBack: () -> Void

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

    override func loadView() {
        view = contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = account.name
        view.backgroundColor = UIColor(named: "SecondaryBackground")
        contentView.configure(
            account: account,
            onBack: onBack
        )
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return navigationController?.viewControllers.count ?? 0 > 1
    }
    
}
