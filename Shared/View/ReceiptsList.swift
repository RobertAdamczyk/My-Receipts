//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ReceiptsList: View {
    var body: some View {
        ScrollView{
            Text("You have no receipts.")
        }
        .navigationTitle("My Receipts")
    }
}

struct ReceiptsList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptsList()
    }
}
