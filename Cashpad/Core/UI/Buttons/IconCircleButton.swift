//
//  IconCircleButton.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 09.01.26.
//

import SwiftUI

struct IconCircleButton: View {

    let systemName: String
    let action: () -> Void

    @State private var isPressed = false

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.primary)
                .frame(width: 38, height: 38)
                .background(
                    Circle()
                        .fill(Color(.systemGray6))
                        .scaleEffect(isPressed ? 0.92 : 1)
                )
        }
        .buttonStyle(.plain)
        .scaleEffect(isPressed ? 0.95 : 1)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
}
