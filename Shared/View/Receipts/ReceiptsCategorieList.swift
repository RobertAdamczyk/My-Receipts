//
//  ReceiptsCategorieList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 11.05.21.
//

import SwiftUI

struct ReceiptsCategorieList: View {
    @EnvironmentObject var coreData: CoreDataViewModel
    var categorie: Categorie
    var body: some View {
        List{
            Section(header: Text("Receipts")) {
                if let receipts = categorie.receipts?.allObjects as? [Receipt] {
                    ForEach(receipts, id: \.self) { receipt in
                        ReceiptRow(receipt: receipt)
                    }
                    .onDelete { i in
                        coreData.removeReceiptInCategorie(at: i, categorie: categorie)
                    }
                    if receipts.isEmpty{
                        Text("You have no receipts here.")
                            .frame(maxWidth: .infinity)
                    }
                }
                
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(categorie.title ?? "Receipts", displayMode: .inline)
    }
}
