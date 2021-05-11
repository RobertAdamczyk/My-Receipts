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
        TextField("Title", text: $viewModel.newReceipt.title) { status in
            if status {
                viewModel.showComponent(value: nil)
            }
        }
    }
}

struct TextFieldRow_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldRow()
    }
}
