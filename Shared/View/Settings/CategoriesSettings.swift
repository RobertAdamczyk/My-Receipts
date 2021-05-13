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
        List{
            if coreDataViewModel.categories.isEmpty {
                Text("You have no categories.")
                    .frame(maxWidth: .infinity, alignment: .center)
            }else {
                Section(header: Text("Categories")) {
                    ForEach(coreDataViewModel.categories) { categorie in
                        Text(categorie.title ?? "No name")
                    }
                    .onDelete(perform: coreDataViewModel.removeCategorie)
                }
            }
           
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Categories", displayMode: .inline)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button("Add") { viewModel.addingCategorie.toggle() }
            }
        }
        .sheet(isPresented: $viewModel.addingCategorie){
            AddCategorieView(showSheet: $viewModel.addingCategorie)
                .environmentObject(coreDataViewModel)
        }
    }
}

struct CategoriesSettings_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CategoriesSettings()
        }
    }
}
