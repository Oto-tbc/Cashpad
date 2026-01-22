//
//  ExchangeViewModel.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 22.01.26.
//

import Foundation
import Combine

@MainActor
final class ExchangeViewModel {
    
    // MARK: - Input (from UI)
    
    @Published var fromCurrency: String = "USD"
    @Published var toCurrency: String = "EUR"
    @Published var amount: Double = 1
    
    // MARK: - Output (to UI)
    
    @Published private(set) var convertedAmount: Double = 0
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var error: String?
    @Published private(set) var availableCurrencies: [String] = []
    
    // MARK: - Dependencies
    
    private let repository: ExchangeRepositoryProtocol
    private var exchangeRate: ExchangeRate?
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Init
    
    init(repository: ExchangeRepositoryProtocol) {
        self.repository = repository
        bind()
    }
    
    // MARK: - Public API
    
    func loadRates() {
        isLoading = true
        error = nil
        
        Task {
            do {
                let rate = try await repository.getLatestRates(base: "USD")
                self.exchangeRate = rate
                
                self.availableCurrencies = Array(rate.rates.keys)
                
                self.recalculate()
                self.isLoading = false
            } catch {
                self.error = error.localizedDescription
                self.isLoading = false
            }
        }
    }
    
    // MARK: - Private
    
    private func bind() {
        Publishers.CombineLatest3(
            $fromCurrency,
            $toCurrency,
            $amount
        )
        .sink { [weak self] _, _, _ in
            self?.recalculate()
        }
        .store(in: &cancellables)
    }
    
    private func recalculate() {
        guard let exchangeRate else {
            convertedAmount = 0
            return
        }
        
        convertedAmount = exchangeRate.convert(
            amount: amount,
            from: fromCurrency,
            to: toCurrency
        )
    }
}

