//
//  ImageRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ImageRow: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    var body: some View {
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
        .roundedBackgroundWithBorder
    }
}

struct ImageRow_Previews: PreviewProvider {
    static var previews: some View {
        ImageRow()
    }
}
