//
//  AddReceipt.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct AddReceipt: View {
    @StateObject var viewModel = AddReceiptViewModel()
    @Binding var showPicker: Bool
    @Binding var showCamera: Bool
    var body: some View {
        ZStack{
            VStack(spacing: 40){
                ImageRow()
                
                VStack(spacing: 20){
                    TextFieldRow()
                    
                    ButtonsStack()
                }
                Spacer()
            }
            .environmentObject(viewModel)
            
            if showCamera {
                Color.blue.ignoresSafeArea()
            }
            
            MyDatePicker(date: $viewModel.newReceipt.dateOfPurchase)
                .offset(x: viewModel.showComponent == .start ? 0 : -400, y:-150)
            MyDatePicker(date: $viewModel.newReceipt.endOfWarranty)
                .offset(x: viewModel.showComponent == .end ? 0 : -400, y:-150)
        }
        .navigationTitle("New Receipt")
        .sheet(isPresented: $showPicker, onDismiss: viewModel.loadImage) {
            ImagePicker(image: $viewModel.inputImage)
        }
        
    }
}

struct AddReceipt_Previews: PreviewProvider {
    static var previews: some View {
        AddReceipt(showPicker: .constant(false), showCamera: .constant(false))
    }
}
