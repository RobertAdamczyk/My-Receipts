//
//  CategoriesSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct CategoriesSettingsView: View {

    @StateObject var viewModel: CategoriesSettingsViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }

    var body: some View {
        List{
            if viewModel.categories.isEmpty {
                Text("You have no categories.")
                    .apply(.regular, size: .M, color: .gray)
                    .frame(maxWidth: .infinity, alignment: .center)
            }else {
                Section(header: Text("Categories")) {
                    ForEach(viewModel.categories) { categorie in
                        Text(categorie.title ?? "###")
                            .apply(.regular, size: .M, color: .gray)
                    }
                    .onDelete(perform: viewModel.onRemoveCategorie)
                }
            }
           
        }
        .listStyle(.grouped)
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: viewModel.onAddCategorieTapped) {
                    Text("Add")
                }
            }
        }
    }
}