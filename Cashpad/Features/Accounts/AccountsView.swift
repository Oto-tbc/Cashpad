//
//  AccountsViewController.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 06.01.26.
//

import SwiftUI

struct AccountsView: View {

    @State private var showSettings = false
    @State private var showAnalythics = false
    
    let accounts: [Account]
    let onAccountSelected: (Account) -> Void

    var body: some View {
        
        ZStack {
            
            VStack {
                
                AccountsNavigationBarView(showSettings: $showSettings)
                
                AccountsCardsListView()
                
            }
            .frame(maxWidth: .infinity)
            
        }
        .background(Color("SecondaryBackground"))
        
    }
}


struct AccountsCardsListView: View {
    
    var body: some View {
        
        ScrollView {
            
            VStack (spacing: 24) {
                
                TotalAccountsBalanceView(currency: "$", balance: "770,231.21", trend: .same)
                
                VStack (spacing: 12) {
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .lower, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .same, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                    AccountsCardsView(accountName: "Personal accound", currency: "$", balance: "330.24", trend: .higher, onDelete: {print("123")})
                }
                
            }
            .padding()
            
        }
        
    }
}


#Preview {
    let sampleAccounts: [Account] = [
        Account(id: UUID(), name: "Checking"),
        Account(id: UUID(), name: "Savings")
    ]
    AccountsView(accounts: sampleAccounts) { account in
        print("Selected: \(account.name)")
    }
}
