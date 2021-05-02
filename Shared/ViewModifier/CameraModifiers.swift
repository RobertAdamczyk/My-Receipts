//
//  CameraModifiers.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI

extension Image {
    var circleBackground : some View {
        self
            .resizable()
            .scaledToFit()
            .frame(height: 15)
            .foregroundColor(.primary)
            .background(Circle()
                            .foregroundColor(Color("Light"))
                            .frame(width: 40, height: 40))
    }
}
