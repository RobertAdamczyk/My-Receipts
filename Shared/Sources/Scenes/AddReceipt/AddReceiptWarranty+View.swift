//
//  WarrantyView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 16.05.21.
//

import SwiftUI

struct AddReceiptWarrantyView: View {
    @ObservedObject var viewModel: AddReceiptViewModel
    var body: some View {
        List {
            Section(header: Text(appText(.addReceipt(.warrantyHint)))){
                Toggle(isOn: $viewModel.warranty.animation()) {
                    Text(appText(.generic(.warranty)))
                        .apply(.regular, size: .M, color: .gray)
                }
            }
            if viewModel.warranty {
                Section{
                    DatePicker(selection: $viewModel.newReceipt.endOfWarranty, displayedComponents: .date) {
                        Text(appText(.addReceipt(.endWarranty)))
                            .apply(.regular, size: .M, color: .gray)
                    }
                }
            }
        }
        .navigationTitle(appText(.generic(.warranty)))
    }
}
