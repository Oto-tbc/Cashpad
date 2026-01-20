//
//  ContentView.swift
//  MapsIOS26BottomSheet
//
//  Created by Balaji Venkatesh on 26/06/25.
//

import SwiftUI

struct TransactionsView: View {
    
    @ObservedObject var viewModel: BalanceViewModel

    @State private var showAllTransactionsView: Bool = true
    @State private var sheetDetent: PresentationDetent = .height(80)
    @State private var sheetHeight: CGFloat = 0
    @State private var animationDuration: CGFloat = 0
    @State private var toolbarOpacity: CGFloat = 1
    @State private var safeAreaBottomInset: CGFloat = 0
    
    
    var body: some View {
        Color.clear
            .safeAreaInset(edge: .bottom, spacing: 0) {
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 80)
            }
            .sheet(isPresented: $showAllTransactionsView) {
                AllTransactionsView(viewModel: viewModel, sheetDetent: $sheetDetent)
                    .presentationDetents([.height(80), .large], selection: $sheetDetent)
                    .presentationBackgroundInteraction(.enabled)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .onGeometryChange(for: CGFloat.self) {
                        max(min($0.size.height, 400 + safeAreaBottomInset), 0)
                    } action: { oldValue, newValue in
                        /// Limiting the offset to 300, so that opacity effect will be visible
                        sheetHeight = min(newValue, 350 + safeAreaBottomInset)
                        
                        /// Calulating Opacity
                        let progress = max(min((newValue - (350 + safeAreaBottomInset)) / 50, 1), 0)
                        toolbarOpacity = 1 - progress
                        
                        /// Calculating Animation Duration
                        let diff = abs(newValue - oldValue)
                        let duration = max(min(diff / 100, maxAnimationDuration), 0)
                        animationDuration = duration
                    }
                    .ignoresSafeArea()
                    .interactiveDismissDisabled()
            }
            .onGeometryChange(for: CGFloat.self, of: {
                $0.safeAreaInsets.bottom
            }, action: { newValue in
                safeAreaBottomInset = newValue
            })
    }
    
    var maxAnimationDuration: CGFloat {
        return 0.25
    }
    
    var animation: Animation {
        .interpolatingSpring(duration: animationDuration, bounce: 0, initialVelocity: 0)
    }
}
