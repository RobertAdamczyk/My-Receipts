//
//  StickyButton.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 10.08.23.
//

import SwiftUI

extension View {

    var stickyButton: some View {
        self
            .padding(16)
            .background {
                Rectangle()
                    .foregroundColor(appColor(.white))
            }
            .background(alignment: .top) {
                Rectangle()
                    .frame(height: 1)
                    .shadow(color: appColor(.black), radius: 8)
            }
    }
}
