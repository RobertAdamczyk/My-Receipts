//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ReceiptsList: View {
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var receipts: FetchedResults<Receipts>
    
    var body: some View {
        ScrollView{
            ForEach(receipts) { receipt in
                Text("\(receipt.title!)")
            }
            if receipts.isEmpty {
                Text("You have no receipts.")
            }
        }
        .navigationTitle("My Receipts")
    }
}

struct ReceiptsList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptsList()
    }
}
