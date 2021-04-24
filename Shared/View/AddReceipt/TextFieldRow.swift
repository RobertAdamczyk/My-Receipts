//
//  TextFieldRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct TextFieldRow: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    var body: some View {
        TextField("", text: $viewModel.newReceipt.title) { status in
            if status {
                viewModel.showComponent(value: nil)
            }
        }
        .overlay(HStack{
            Text(viewModel.newReceipt.title == "" ?
                    "Title" : "").foregroundColor(Color("Grey").opacity(0.6))
            Spacer()
        })
        .formLook
    }
}

struct TextFieldRow_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldRow()
    }
}
