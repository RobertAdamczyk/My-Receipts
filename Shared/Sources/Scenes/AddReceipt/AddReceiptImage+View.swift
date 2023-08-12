//
//  ImageRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct AddReceiptImageView: View {
    @EnvironmentObject var viewModel: AddReceiptViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        ZStack{
            if let uiimage = viewModel.newReceipt.uiImage {
                Image(uiImage: uiimage)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: UIScreen.main.bounds.width*0.6)
                    .cornerRadius(15)
                    
            }else{
                VStack(spacing: 20){
                    appImage(.photoFill)
                        .resizable()
                        .frame(width: 40, height: 30)
                        .padding(.horizontal, 60)
                    Text(appText(.addReceipt(.loadImage)))
                        .apply(.regular, size: .M, color: .gray)
                }
                .padding(.vertical, 100)
            }
        }
        .roundedBackgroundWithBorder
        .onTapGesture(perform: viewModel.onImageTapped)
    }
}
