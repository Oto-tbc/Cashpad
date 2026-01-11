//
//  GlassButtonHelper.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 10.01.26.
//

import SwiftUI

extension View {

    @ViewBuilder
    func glassButtonStyleIfAvailable() -> some View {
        if #available(iOS 26.0, *) {
            self.buttonStyle(.glass)
        } else {
            self.buttonStyle(JumpyButtonStyle())
        }
    }

    @ViewBuilder
    func glassButtonBackgroundIfAvailable() -> some View {
        if #available(iOS 26.0, *) {
            self
        } else {
            self.background(
                Circle()
                    .fill(Color(.systemGray6))
            )
        }
    }
}
