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
        self.apiKey = apiKey.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    func fetchLatestRates(base: String) async throws -> ExchangeRate {
        print("🔑 API KEY USED:", apiKey)

        var components = URLComponents(
            string: "https://api.freecurrencyapi.com/v1/latest"
        )!
        components.queryItems = [
            URLQueryItem(name: "apikey", value: apiKey)
        ]

        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        print("🌍 FULL REQUEST URL:")
        print(url.absoluteString)

        let (data, response) = try await session.data(from: url)

        guard let http = response as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }

        if http.statusCode != 200 {
            let body = String(data: data, encoding: .utf8) ?? "No body"
            print("❌ HTTP Status:", http.statusCode)
            print("❌ Response body:", body)
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(
            ExchangeRateResponseDTO.self,
            from: data
        )

        return ExchangeRate(
            base: "USD",
            rates: decoded.data,
            fetchedAt: Date()
        )
    }
}
