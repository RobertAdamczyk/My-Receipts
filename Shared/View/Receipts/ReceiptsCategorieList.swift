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
                    .onDelete(perform: coreData.removeReceipt)
                }else {
                    Text("You have no receipts.")
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(categorie.title ?? "Receipts", displayMode: .inline)
    }
}
