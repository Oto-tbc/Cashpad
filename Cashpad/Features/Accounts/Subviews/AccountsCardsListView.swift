//
//  AccountsCardsListView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 11.01.26.
//


import SwiftUI

struct AccountsCardsListView: View {
    
    var body: some View {
        
        ScrollView {
            
            VStack (spacing: 16) {
                
                TotalAccountsBalanceView(currency: "$", balance: "770,231.21", trend: .same)
                
                VStack (spacing: 12) {
                    
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .lower, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .same, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                    
                }
                
            }
            .padding(16)
            
        }
        
    }
}
