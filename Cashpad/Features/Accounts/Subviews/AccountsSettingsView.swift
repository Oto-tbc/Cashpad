//
//  SettingsView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 10.01.26.
//

import SwiftUI

struct AccountsSettingsView: View {

    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack(spacing: 16) {

            Text("Settings")
                .font(.headline)

            Button("Close") {
                dismiss()
            }

            Spacer()
        }
        .padding()
    }
    
}
