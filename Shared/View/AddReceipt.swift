//
//  AddReceipt.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct AddReceipt: View {
    @ObservedObject var viewModel = AddReceiptViewModel()
    @Binding var showPicker: Bool
    @Binding var showCamera: Bool
    var body: some View {
        VStack{
            Text("Add")
        }
        .navigationTitle("New Receipt")
        .sheet(isPresented: $showPicker, onDismiss: viewModel.loadImage) { ImagePicker(image: $viewModel.inputImage) }
    }
}

struct AddReceipt_Previews: PreviewProvider {
    static var previews: some View {
        AddReceipt(showPicker: .constant(false), showCamera: .constant(false))
    }
}
