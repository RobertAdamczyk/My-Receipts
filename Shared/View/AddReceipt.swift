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
                ZStack{
                    if viewModel.newReceipt.image != nil {
                        viewModel.newReceipt.image!
                            .resizable()
                            .cornerRadius(15)
                            
                    }else{
                        VStack(spacing: 20){
                            Image(systemName: "photo.fill")
                                .resizable()
                                .frame(width: 40, height: 30)
                            Text("Load Image")
                        }
                    }
                }
                .frame(width: 220, height: 352)
                .background(Color("Light").cornerRadius(25))
                
                VStack(spacing: 20){
                    TextField("", text: $viewModel.newReceipt.title)
                        .overlay(HStack{
                            Text(viewModel.newReceipt.title == "" ?
                                    "Title" : "").foregroundColor(Color("Grey").opacity(0.6))
                            Spacer()
                        })
                        .formLook
                    
                    Button(action:{
                        
                    }){
                        HStack{
                            Text("Date of Purchase")
                                .foregroundColor(Color("Grey").opacity(0.6))
                            Spacer()
                            Text("\(viewModel.newReceipt.dateOfPurchase, style: .date)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Blue"))
                        }
                        .formLook
                    }
                    
                    Button(action:{
                        
                    }){
                        HStack{
                            Text("End of Warranty")
                                .foregroundColor(Color("Grey").opacity(0.6))
                            Spacer()
                            Text("\(viewModel.newReceipt.endOfWarranty, style: .date)")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Blue"))
                        }
                        .formLook
                    }
                    
                    Button(action:{
                        
                    }){
                        HStack{
                            Spacer()
                            Text("Done")
                                .fontWeight(.semibold)
                                .foregroundColor(Color("Blue"))
                            Spacer()
                        }
                        .formLook
                    }
                }
                
                Spacer()
            }
            
            if showCamera {
                Color.blue.ignoresSafeArea()
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
        AddReceipt(showPicker: .constant(false), showCamera: .constant(false))
    }
}
