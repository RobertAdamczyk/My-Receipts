//
//  SortByView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 14.05.21.
//

import SwiftUI

struct SortByView: View {

    let completion: (SortBy) -> Void

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: -0.5){
                Text(appText(.sortBy(.title)))
                    .apply(.medium, size: .L, color: .black)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                Divider()
                ScrollView{
                    VStack(spacing: 8) {
                        ForEach(SortBy.allCases, id: \.self) { item in
                            Button(action: {
                                completion(item)
                            }) {
                                Text("\(item.info.name)")
                                    .apply(.regular, size: .M, color: .black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(8)
                            }
                            Divider()
                                .padding(.horizontal, 8)
                        }
                    }
                    .padding(.vertical, 8)
                }
            }
            .background {
                appGradient(.primary).ignoresSafeArea()
            }
        }
    }
}
