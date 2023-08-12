//
//  ChooseCategorieView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 11.05.21.
//

import SwiftUI

struct AddReceiptCategorie: View {
    @ObservedObject var viewModel: AddReceiptViewModel
    var body: some View {
        List {
            Section(header: Text(appText(.addReceipt(.categoryHint)))){
                ForEach(viewModel.categories, id: \.self) { categorie in
                    AppButton(.form(.checkmark(categorie.title ?? "",
                                               viewModel.newReceipt.categorie == categorie))) {
                        onCategorieTapped(categorie)
                    }
                }
            }
            
        }
        .navigationTitle(appText(.generic(.categories)))
    }

    func onCategorieTapped(_ categorie: Categorie) {
        viewModel.newReceipt.categorie = viewModel.newReceipt.categorie != categorie ? categorie : nil
    }
}

