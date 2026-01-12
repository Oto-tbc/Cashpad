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
                
                Text("Settings")
                    .font(.title2.bold())

            }

            Divider()

            Text("Settings content goes here")
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding(24)
        .frame(
            maxWidth: UIScreen.main.bounds.width - 20,
            maxHeight: UIScreen.main.bounds.height
        )
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color("SecondaryBackground"))
                .matchedGeometryEffect(id: "analytics", in: animation, isSource: showAnalytics)
        )
    }
}
