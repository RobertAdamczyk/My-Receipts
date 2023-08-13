//
//  AboutView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.06.21.
//

import SwiftUI

struct AboutView: View {

    private var versionText: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "#error"
    }

    var body: some View {
        Form{
            Section {
                Image("AppIconImage")
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
                    Text("\(appText(.generic(.version))): \(versionText)")
                    Text(appText(.settings(.aboutCreatedBy)))
                }
                .apply(.regular, size: .M, color: .gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
            Section {
                VStack(spacing: 16) {
                    Text(appText(.settings(.aboutThankYou)))
                }
                .apply(.regular, size: .M, color: .gray)
                .frame(maxWidth: .infinity)
                .multilineTextAlignment(.center)
            }
        }
        .navigationTitle(appText(.generic(.informations)))
    }
}
