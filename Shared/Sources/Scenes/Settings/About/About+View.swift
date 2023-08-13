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
        Form {
            Section {
                Image("AppIconImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 32)
                    .background(Color(UIColor.systemGroupedBackground))
                    .listRowInsets(EdgeInsets())
            }

            Section {
                HStack(spacing: 16) {
                    Text(appText(.generic(.version)))
                    Spacer()
                    Text(versionText)
                }
                .apply(.regular, size: .M, color: .gray)
                HStack(spacing: 16) {
                    Text(appText(.generic(.author)))
                    Spacer()
                    Text("Robert Adamczyk")
                        .apply(.regular, size: .S, color: .gray)
                }
                .apply(.regular, size: .M, color: .gray)
                HStack(spacing: 8) {
                    Text(appText(.generic(.contact)))
                    Spacer()
                    Link(destination: URL(string: "mailto@robert.adamczyk.appstore@gmail.com")!) {
                        Text("robert.adamczyk.appstore@gmail.com")
                            .apply(.regular, size: .S, color: .gray)
                    }
                }
                .apply(.regular, size: .M, color: .gray)
            }
            Section {
                HStack(spacing: 16) {
                    Text(appText(.generic(.appStore)))
                    Spacer()
                    Link(destination: URL(string: "https://apps.apple.com/us/app/receipts-store/id1570651530")!) {
                        EmptyView()
                    }
                }
                .apply(.regular, size: .M, color: .gray)
                HStack(spacing: 16) {
                    Text(appText(.generic(.github)))
                    Spacer()
                    Link(destination: URL(string: "https://github.com/LogiCCPL/My-Receipts")!) {
                        EmptyView()
                    }
                }
                .apply(.regular, size: .M, color: .gray)
            }
        }
        .navigationTitle(appText(.generic(.informations)))
    }
}
