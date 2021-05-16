//
//  ReceiptsCategorieList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 11.05.21.
//

import SwiftUI

struct ReceiptsCategorieList: View {
    @EnvironmentObject var coreData: CoreDataViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    var categorie: Categorie
    var body: some View {
        List{
            Section(header: Text("Receipts")) {
                ForEach(coreData.filteredReceiptsInCategorie, id: \.self) { receipt in
                    ReceiptRow(receipt: receipt)
                }
                .onDelete { i in
                    coreData.removeReceiptInCategorie(at: i, categorie: categorie)
                    coreData.fetchReceiptsInCategorie(categorie: categorie)
                }
                if coreData.filteredReceiptsInCategorie.isEmpty{
                    Text("You have no receipts here.")
                        .frame(maxWidth: .infinity)
                }
                
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(categorie.title ?? "Receipts", displayMode: .inline)
        .toolbar{
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action:{
                    withAnimation{
                        homeViewModel.showSortBy.toggle()
                    }
                    
                }){
                    Image(systemName: "ellipsis")
                }
            }
        }
        .onAppear(){
            coreData.fetchReceiptsInCategorie(categorie: categorie)
        }
        .onChange(of: coreData.sortBy) { _ in
            withAnimation{
                coreData.fetchReceiptsInCategorie(categorie: categorie)
            }
        }
    }
}
