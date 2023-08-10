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
            Section(header: Text("Choose categorie for the receipt.")){
                ForEach(viewModel.categories, id: \.self) { categorie in
                    AppButton(.form(.checkmark(categorie.title ?? "",
                                               viewModel.newReceipt.categorie == categorie))) {
                        onCategorieTapped(categorie)
                    }
                }
            }
            
        }
        .navigationTitle("Categorie".localized())
    }

    func onCategorieTapped(_ categorie: Categorie) {
        viewModel.newReceipt.categorie = viewModel.newReceipt.categorie != categorie ? categorie : nil
    }
}

