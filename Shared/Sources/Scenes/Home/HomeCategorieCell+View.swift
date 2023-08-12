//
//  CategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.05.21.
//

import SwiftUI

struct HomeCategorieCell: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var categorie: Categorie?
    var count: Int

    init(categorie: Categorie? = nil, count: Int = 0) {
        self.categorie = categorie
        self.count = count
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(categorie?.symbol ?? appText(.home(.firstLetterDefaultCategory)))
                .apply(.medium, size: .H1, color: .black)
            Text(categorie?.title ?? appText(.home(.defaultCategory)))
                .apply(.regular, size: .S, color: .gray)
                .lineLimit(1)
            Text("\(categorie?.receipts?.count ?? count) \(appText(.generic(.receipts)).lowercased())")
                .apply(.regular, size: .XS, color: .gray)
                .lineLimit(1)
        }
        .padding(.leading, 15)
        .frame(width: 100, height: 100, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(viewModel.selectedCategorie == categorie ?
                      appGradient(.primary) :
                        LinearGradient(gradient: Gradient(colors: [.white, .white]), startPoint: .top, endPoint: .bottom))
                .frame(width: 100, height: 100)
                .shadow(color: appColor(.shadow), radius: 8, x: 0, y: 0)
        )
        .overlay(alignment: .topTrailing) {
            appImage(.ellipsis)
                .rotationEffect(.init(degrees: 90))
                .padding(.top, 20)
                .padding(.trailing, 5)
        }
    }
}
