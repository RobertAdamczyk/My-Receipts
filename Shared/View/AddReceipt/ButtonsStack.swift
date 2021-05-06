//
//  ButtonsStack.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ButtonsStack: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        Button(action:{
            viewModel.showComponent(value: .start)
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
            viewModel.showComponent(value: .end)
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
            if viewModel.checkTitleAndImage() {
                viewModel.save()
                homeViewModel.view = .list
            }
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
}

struct ButtonsStack_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsStack()
    }
}
