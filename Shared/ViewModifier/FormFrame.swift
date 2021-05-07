//
//  FormFrame.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

extension View {
    var formLook: some View {
        self
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(Color("Light"))
            .overlay(
                VStack{
                    Rectangle().frame(height:0.7)
                    Spacer()
                    Rectangle().frame(height:0.7)
                }
                .foregroundColor(Color("BorderColor"))
            )
    }
}
