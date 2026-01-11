//
//  AccountsNavigationBarView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 09.01.26.
//

import SwiftUI

struct AccountsNavigationBarView: View {

    @Binding var showSettings: Bool
    let animation: Namespace.ID

    var body: some View {
        HStack(alignment: .top) {

            Text("Accounts")
                .font(Font.system(size: 36))

            Spacer()

            HStack(spacing: 16) {

                IconCircleButton(
                    systemName: "chart.line.uptrend.xyaxis",
                    action: { print("123") }
                )

                IconCircleButton(
                    systemName: "gearshape",
                    action: {
                        guard !showSettings else { return }
                        showSettings = true
                    }
                )
                .matchedGeometryEffect(id: "settings", in: animation, isSource: !showSettings)

            }

        }
        .padding(.horizontal, 24)
        .padding(.bottom, 18)
        .padding(.top, -22)
        .background(Color("Background"))
    }
}
