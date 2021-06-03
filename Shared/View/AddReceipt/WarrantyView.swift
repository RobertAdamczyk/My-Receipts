//
//  WarrantyView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 16.05.21.
//

import SwiftUI

struct WarrantyView: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    var body: some View {
        List{
            Section(header: Text("Is there a guarantee for the receipt?").padding(.top, 70)){
                Toggle("Warranty", isOn: $viewModel.warranty.animation())
            }
            
            if viewModel.warranty {
                Section{
                    DatePicker("End of Warranty", selection: $viewModel.newReceipt.endOfWarranty, displayedComponents: .date)
                        .accentColor(.blue)
                }
            }
            
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarHidden(true)
        .overlay(NavigationTopBar(title: "Warranty", backButton: true).ignoresSafeArea(), alignment: .top)
        .navigationBarTitle("Warranty", displayMode: .inline)
    }
}

struct WarrantyView_Previews: PreviewProvider {
    static var previews: some View {
        WarrantyView()
    }
}
