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
    var body: some View {
        ScrollView{
            ZStack{
                Color.clear
                    .frame(height: UIScreen.main.bounds.height)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.showComponent(value: nil)
                    }
                
                VStack(spacing: 40){
                    ImageRow()
                    
                    VStack(spacing: 20){
                        TextFieldRow()
                        
                        ButtonsStack()
                    }
                    Spacer()
                }
                .environmentObject(viewModel)
                
                MyDatePicker(date: $viewModel.newReceipt.dateOfPurchase)
                    .offset(x: viewModel.showComponent == .start ? 0 : -400, y:-170)
                MyDatePicker(date: $viewModel.newReceipt.endOfWarranty)
                    .offset(x: viewModel.showComponent == .end ? 0 : -400, y:-170)
            }
        }
        .navigationTitle("New Receipt")
        .sheet(isPresented: $showPicker, onDismiss: viewModel.loadImage) {
            ImagePicker(image: $viewModel.inputImage)
        }
        
    }
}

struct AddReceipt_Previews: PreviewProvider {
    static var previews: some View {
        AddReceipt(showPicker: .constant(false))
    }
}
