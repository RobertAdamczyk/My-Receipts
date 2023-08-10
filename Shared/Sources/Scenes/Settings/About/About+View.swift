//
//  AboutView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.06.21.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        Form{
            Section {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
            }
            Section {
                VStack(spacing: 5){
                    Text("Version: 1.0.1")
                    Text("Created by: Robert Adamczyk")
                }
                .apply(.regular, size: .M, color: .gray)
                .frame(maxWidth: .infinity)
            }
            Section {
                VStack(spacing: 16) {
                    Text("Thanks for using my application.")
                    Text("❤️❤️❤️")
                    Text("If you like it, leave a review on the AppStore.")
                }
                .apply(.regular, size: .M, color: .gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
        }
        .navigationTitle("About")
    }
}
