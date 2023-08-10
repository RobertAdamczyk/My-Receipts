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
        List{
            Section(header: Text("Choose categorie for the receipt.")){
                ForEach(viewModel.categories, id: \.self) { categorie in
                    Button(action: {
                        viewModel.newReceipt.categorie = viewModel.newReceipt.categorie != categorie ? categorie : nil
                    }){
                        HStack{
                            Text(categorie.title ?? "")
                                .apply(.regular, size: .M, color: .gray)
                                .lineLimit(1)
                            Spacer()
                            if viewModel.newReceipt.categorie == categorie {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            }
            
        }
        .navigationTitle("Categorie".localized())
    }
}

