//
//  AddAccountSheetHelpers.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 13.01.26.
//

import SwiftUI

extension AddAccountSheet {

    @ViewBuilder
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(.primary)
    }

    @ViewBuilder
    func sectionContainer<Content: View>(
        @ViewBuilder content: () -> Content
    ) -> some View {
        content()
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color("Background"))
            )
    }
}
