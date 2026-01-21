//
//  ExchangeRate.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 21.01.26.
//

import Foundation

struct ExchangeRate {
    let base: String
    let rates: [String: Double]
    let fetchedAt: Date
}
