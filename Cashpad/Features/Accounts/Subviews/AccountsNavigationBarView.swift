//
//  AccountsNavigationBarView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 09.01.26.
//

import SwiftUI

struct AccountsNavigationBarView: View {
    
    @Binding var showSettings: Bool
    
    var body: some View {
        HStack(alignment: .top) {
            
            Text("Accounts")
                .font(Font.system(size: 36))
            
            Spacer()
            
            HStack(spacing: 16) {
            
                IconCircleButton(systemName: "chart.line.uptrend.xyaxis", action: { print("123") })
                
                IconCircleButton(systemName: "gearshape", action: { showSettings = true  })
            
            }
            
        }
        .padding(.horizontal, 24)
        .padding(.bottom, 8)
        .background(Color("Background"))
    }
    
}
