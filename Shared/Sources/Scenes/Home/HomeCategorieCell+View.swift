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
    var count: Int?
    @State var title = "Categorie"
    @State var symbol = "C"
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(categorie != nil ? symbol : "A")
                .apply(.medium, size: .H1, color: .black)
            Text(categorie != nil ? title : "All".localized())
                .apply(.regular, size: .S, color: .gray)
                .lineLimit(1)
            Text("\(count == nil ? categorie?.receipts?.count ?? 0 : count!) receipts")
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
        .overlay(Image(systemName: "ellipsis")
            .rotationEffect(.init(degrees: 90))
            .padding(.top, 20)
            .padding(.trailing, 5), alignment: .topTrailing)
        .onAppear() {
            if let unwrappedTitle = categorie?.title {
                title = unwrappedTitle
            }
            if let unwrappedSymbol = categorie?.symbol {
                symbol = unwrappedSymbol
            }
        }
    }
}
