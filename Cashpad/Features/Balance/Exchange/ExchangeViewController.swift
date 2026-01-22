//
//  ExchangeViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 21.01.26.
//

import UIKit
import Combine

final class ExchangeViewController: UIViewController {
    
    private let viewModel: ExchangeViewModel
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: ExchangeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "Background")
        title = "Exchange"
        
        setupNavigation()
        setupExchange()
        bindViewModel()
        print("🚀 Calling loadRates()")
        viewModel.loadRates()
    }
    
    // MARK: - UI
    
    private func setupNavigation(){
        navigationController?.setNavigationBarHidden(false, animated: false)

        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(handleBack)
        )
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupExchange() {
        
    }
    
    @objc private func handleBack() {
        navigationController?.popViewController(animated: true)
    }
    
    private func bindViewModel() {

        // 🔹 THIS is how you print currencies correctly
        viewModel.$availableCurrencies
            .sink { currencies in
                print("✅ Available currencies from API:")
                print(currencies)
            }
            .store(in: &cancellables)

        viewModel.$convertedAmount
            .sink { value in
                print("💱 Converted amount:", value)
            }
            .store(in: &cancellables)

        viewModel.$error
            .sink { error in
                if let error {
                    print("❌ Error:", error)
                }
            }
            .store(in: &cancellables)
    }
    
}

#Preview {
    ExchangeViewController(viewModel: AppDIContainer.shared.makeExchangeViewModel())
}
