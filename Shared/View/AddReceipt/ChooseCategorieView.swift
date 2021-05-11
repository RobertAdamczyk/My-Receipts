//
//  ChooseCategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 11.05.21.
//

import SwiftUI

struct ChooseCategorieView: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    var categories: [Categorie]
    var body: some View {
        List{
            ForEach(categories, id: \.self) { categorie in
                Button(action: {
                    viewModel.newReceipt.categorie = categorie
                }){
                    HStack{
                        Text(categorie.title ?? "")
                            .foregroundColor(.primary)
                        Spacer()
                        if viewModel.newReceipt.categorie == categorie {
                            Text(Image(systemName: "checkmark"))
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Categorie", displayMode: .inline)
    }
}
