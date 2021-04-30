//
//  ReceiptRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ReceiptRow: View {
    @EnvironmentObject var viewModel: ReceiptViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var image : Image?
    @State var uiimage: UIImage?
    var receipt: Receipts
    var body: some View {
        HStack{
            ZStack{
                Color("Light")
                    .frame(width: 50, height: 67)
                    .cornerRadius(5)
                if let unwarppedImage = image {
                    unwarppedImage
                        .resizable()
                        .frame(width: 50, height: 67)
                        .cornerRadius(5)
                        .onTapGesture{
                            withAnimation{
                                homeViewModel.selectedImage = uiimage
                            }
                        }
                }
            }.onAppear(){
                if let dataImage = receipt.image {
                    if let unwrappedUiImage = UIImage(data: dataImage) {
                        image = Image(uiImage: unwrappedUiImage)
                        uiimage = unwrappedUiImage
                    }
                }
            }
            
                
            VStack(alignment: .leading, spacing: 5) {
                if let title = receipt.title {
                    Text("\(title)")
                        .font(.title3)
                        .fontWeight(.medium)
                }
                if let purchase = receipt.dateOfPurchase {
                    Text("Purchase: \(purchase, style: .date)")
                }
                if let warranty = receipt.endOfWarranty {
                    Text("Warranty to: \(warranty, style: .date)")
                }
            }
        }
    }
}
