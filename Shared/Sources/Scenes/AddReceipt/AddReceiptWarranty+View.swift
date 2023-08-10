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
            Section(header: Text("Is there a guarantee for the receipt?")){
                Toggle(isOn: $viewModel.warranty.animation()) {
                    Text("Guarantee")
                        .apply(.regular, size: .M, color: .gray)
                }
            }
            if viewModel.warranty {
                Section{
                    DatePicker(selection: $viewModel.newReceipt.endOfWarranty, displayedComponents: .date) {
                        Text("End of Guarantee")
                            .apply(.regular, size: .M, color: .gray)
                    }
                }
            }
        }
        .navigationTitle("Guarantee".localized())
    }
}
