//
//  ExchangeRateRepositoryProtocol.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 22.01.26.
//


import Foundation

protocol ExchangeRepositoryProtocol {
    func getLatestRates(base: String) async throws -> ExchangeRate
}

final class ExchangeRepository: ExchangeRepositoryProtocol {

    private let service: ExchangeServiceProtocol
    private let cacheTTL: TimeInterval = 6 * 60 * 60

    private var cachedRate: ExchangeRate?

    init(service: ExchangeServiceProtocol) {
        self.service = service
    }

    func getLatestRates(base: String) async throws -> ExchangeRate {

        if
            let cachedRate,
            cachedRate.base == base,
            Date().timeIntervalSince(cachedRate.fetchedAt) < cacheTTL
        {
            return cachedRate
        }

        let freshRate = try await service.fetchLatestRates(base: base)
        cachedRate = freshRate
        return freshRate
    }
}

