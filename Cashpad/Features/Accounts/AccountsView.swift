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
    
    @Namespace private var settingsAnimation
    
    let accounts: [Account]
    let onAccountSelected: (Account) -> Void

    var body: some View {
        
        ZStack (alignment: .bottomTrailing) {
            
            VStack {
                
                AccountsNavigationBarView(showSettings: $showSettings, animation: settingsAnimation)
                
                AccountsCardsListView()
                
            }
            .frame(maxWidth: .infinity)
            .blur(radius: showSettings ? 8 : 0)
            .allowsHitTesting(!showSettings)

            AddButtonView(onAction: {print("button tapped")})
                        
            if showSettings {
                SettingsModalView(
                    showSettings: $showSettings,
                    animation: settingsAnimation
                )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    Color.black.opacity(0.2)
                        .ignoresSafeArea()
                        .onTapGesture { showSettings = false }
                )
            }
            
        }
        .animation(.spring(response: 0.45, dampingFraction: 0.85), value: showSettings)
        .background(Color("SecondaryBackground"))
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
