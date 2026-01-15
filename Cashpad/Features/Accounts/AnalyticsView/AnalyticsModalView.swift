//
//  AnalyticsModalView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 11.01.26.
//

import SwiftUI

struct AnalyticsModalView: View {

    @Binding var showAnalytics: Bool
    let animation: Namespace.ID

    var body: some View {
        VStack(spacing: 16) {

            HStack {
                Button {
                    showAnalytics = false
                } label: {
                    HStack {
                        Image(systemName: "chevron.backward")
                        Text("Go back")
                    }
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundStyle(Color("AppleBlue"))
                }
                
                Spacer()
                
                Text("Analytics")
                    .font(.title2.bold())

            }

            Divider()

            Text("in progress...")
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(.ultraThinMaterial)
                .matchedGeometryEffect(id: "analyticsGlass", in: animation)
        )
        .ignoresSafeArea(edges: .bottom)
        .padding(.horizontal, 5)
    }
}
