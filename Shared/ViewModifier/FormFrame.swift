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
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 0.7)
                    .foregroundColor(Color("BorderColor"))
            )
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color("Light"))
            )
            .padding(.horizontal)
    }
    
    var roundedBackgroundWithBorder : some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .stroke(lineWidth: 0.7)
                            .foregroundColor(Color("BorderColor"))
            )
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .foregroundColor(Color("Light"))
            )
    }
}
