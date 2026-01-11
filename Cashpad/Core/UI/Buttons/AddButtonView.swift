//
//  addButtonView.swift
//  Cashpad
//
//  Created by Oto Sharvashidze on 11.01.26.
//


import SwiftUI

struct AddButtonView: View {
    
    var onAction: () -> Void
    
    var body: some View {
        Button {
            onAction()
        } label: {
            Image(systemName: "plus")
                .font(.system(size: 22, weight: .regular))
                .foregroundStyle(.white)
                .frame(width: 64, height: 64)
                .background(Color("AppleBlue"))
                .clipShape(Circle())
                .shadow(color: .black.opacity(0.1), radius: 3, x: 0, y: 4)
                .shadow(color: .black.opacity(0.1), radius: 7.5, x: 0, y: 10)
        }
        .buttonStyle(JumpyButtonStyle())
        .padding(.trailing, 32)
        .padding(.bottom, 32)
    }
}
