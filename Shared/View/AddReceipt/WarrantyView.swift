//
//  WarrantyView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 16.05.21.
//

import SwiftUI

struct WarrantyView: View {
    @ObservedObject var viewModel: AddReceiptViewModel
    var body: some View {
        List {
            Section(header: Text("Is there a guarantee for the receipt?")){
                Toggle("Guarantee", isOn: $viewModel.warranty.animation())
            }
            
            if viewModel.warranty {
                Section{
                    DatePicker("End of Guarantee", selection: $viewModel.newReceipt.endOfWarranty, displayedComponents: .date)
                        .accentColor(.blue)
                }
            }
        }
        .navigationTitle("Guarantee".localized())
    }
}
