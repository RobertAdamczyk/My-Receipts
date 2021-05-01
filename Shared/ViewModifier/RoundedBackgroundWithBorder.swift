//
//  RoundedBackgroundWithBorder.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

extension View {
    var roundedBackgroundWithBorder : some View {
        self
            .background(
                RoundedRectangle(cornerRadius: 15)
                            .stroke(lineWidth: 1)
                            .foregroundColor(Color("BorderColor"))
                    .background(RoundedRectangle(cornerRadius: 15).foregroundColor(Color("Light")))
            )
    }
}
