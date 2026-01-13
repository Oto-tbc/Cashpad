//
//  Currency.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 13.01.26.
//


enum Currency: String, CaseIterable, Identifiable {
    case usd = "USD"
    case eur = "EUR"
    case gbp = "GBP"
    case gel = "GEL"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gbp: return "£"
        case .gel: return "₾"
        }
    }
}