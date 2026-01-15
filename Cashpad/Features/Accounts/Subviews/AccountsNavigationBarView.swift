//
//  AccountsNavigationBarView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 09.01.26.
//

import SwiftUI

struct AccountsNavigationBarView: View {

    @Binding var showSettings: Bool
    @Binding var showAnalytics: Bool
    let animation: Namespace.ID

    var body: some View {
        HStack(alignment: .top) {

            Text("Accounts")
                .font(Font.system(size: 36))

            Spacer()

            HStack(spacing: 16) {

                IconCircleButton(
                    systemName: "chart.line.uptrend.xyaxis",
                    action: {
                        guard !showAnalytics else { return }
                        showAnalytics = true
                    }
                )
                .applyIf(!showAnalytics) {
                    $0.matchedGeometryEffect(id: "analyticsGlass", in: animation)
                }
                
                IconCircleButton(
                    systemName: "gearshape",
                    action: {
                        guard !showSettings else { return }
                        showSettings = true
                    }
                )
                .applyIf(!showSettings) {
                    $0.matchedGeometryEffect(id: "settingsGlass", in: animation)
                }
            }

        }
        .padding(.horizontal, 24)
        .padding(.bottom, 18)
        .padding(.top, -18)
        .background(Color("Background"))
    }
}
