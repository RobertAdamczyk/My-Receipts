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
            Section(header: Text("Choose categorie for the receipt.").padding(.top, 70)){
                ForEach(categories, id: \.self) { categorie in
                    Button(action: {
                        viewModel.newReceipt.categorie = viewModel.newReceipt.categorie != categorie ? categorie : nil
                    }){
                        HStack{
                            Text(categorie.title ?? "")
                                .foregroundColor(.primary)
                                .lineLimit(1)
                            Spacer()
                            if viewModel.newReceipt.categorie == categorie {
                                Text(Image(systemName: "checkmark"))
                                    .fontWeight(.bold)
                            }
                        }
                    }
                }
            }
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarHidden(true)
        .overlay(NavigationTopBar(title: "Categorie", backButton: true).ignoresSafeArea(), alignment: .top)
        .navigationBarTitle("Categorie", displayMode: .inline)
    }
}
