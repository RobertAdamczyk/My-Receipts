//
//  CategoriesSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import SwiftUI

struct CategoriesSettings: View {
    @ObservedObject var coreDataViewModel = CoreDataViewModel()
    @ObservedObject var viewModel = CategoriesSettingsViewModel()
    var body: some View {
        VStack{
            List{
                if coreDataViewModel.categories.isEmpty {
                    Text("You have no categories.")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                ForEach(coreDataViewModel.categories) { categorie in
                    Text(categorie.title ?? "")
                }
                .onDelete(perform: coreDataViewModel.removeCategorie)
            }
            .listStyle(PlainListStyle())
            Spacer()
            if viewModel.addingCategorie {
                TextField("Title", text: $viewModel.title)
                    .overlay(
                        Button("Save") {
                            coreDataViewModel.addCategorie(title: viewModel.title)
                        }
                        ,alignment: .trailing)
            }
        }
        
        .navigationTitle("Categories")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Add") {
                    withAnimation{
                        viewModel.addingCategorie.toggle()
                    }
                }
            }
        }
    }
}

struct CategoriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesSettings()
    }
}
