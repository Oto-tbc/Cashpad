//
//  ExchangeService.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 21.01.26.
//

import Foundation

protocol ExchangeServiceProtocol {
    func fetchLatestRates(base: String) async throws -> ExchangeRate
}

final class ExchangeService: ExchangeServiceProtocol {

    private let apiKey: String
    private let session: URLSession

    init(session: URLSession = .shared, apiKey: String) {
        self.session = session
        self.apiKey = apiKey
    }

    func fetchLatestRates(base: String) async throws -> ExchangeRate {

        var components = URLComponents(string: "https://api.freecurrencyapi.com/v1/latest")!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey),
            URLQueryItem(name: "base_currency", value: base)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(
            ExchangeRateResponseDTO.self,
            from: data
        )

        return ExchangeRate(
            base: base,
            rates: decoded.data,
            fetchedAt: Date()
        )
    }
}
