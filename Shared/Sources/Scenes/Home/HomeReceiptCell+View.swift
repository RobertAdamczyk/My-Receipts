//
//  ReceiptRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct HomeReceiptCell: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var image : Image?
    @State var uiimage: UIImage?
    var receipt: Receipt
    var body: some View {
        HStack{
            ZStack{
                if let unwarppedImage = image {
                    unwarppedImage
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 75, maxHeight: 75)
                        .cornerRadius(5)
                        .onTapGesture{
                            homeViewModel.onImageTapped(image: uiimage)
                        }
                }else {
                    Color("grey")
                        .frame(width: 50, height: 67)
                        .cornerRadius(5)
                }
            }
            .padding(.horizontal, 10)
            .onAppear(){
                if let im = CacheRepository.shared.get(forKey: receipt.id?.uuidString ?? ""){
                    image = Image(uiImage: im)
                    uiimage = im
                    return
                }
                guard let dataImage = receipt.image else { return }
                guard let unwrappedUIImage = UIImage(data: dataImage) else { return }
                
                CacheRepository.shared.set(forKey: receipt.id?.uuidString ?? "", image: unwrappedUIImage)
                image = Image(uiImage: unwrappedUIImage)
                uiimage = unwrappedUIImage
            }
            VStack(alignment: .leading, spacing: 8){
                if let title = receipt.title {
                    Text(title)
                        .apply(.medium, size: .M, color: .gray)
                }
                if let purchase = receipt.dateOfPurchase {
                    Text("Purchase: \(purchase, style: .date)")
                        .apply(.regular, size: .S, color: .gray)
                }
                if let warranty = receipt.endOfWarranty {
                    Text("Guarantee to: \(warranty, style: .date)")
                        .apply(.regular, size: .S, color: .gray)
                }
                
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(appColor(.white))
                .shadow(color: appColor(.shadow), radius:8, x:0, y:0)
        )
        .overlay(alignment: .topTrailing) {
            appImage(.ellipsis)
                .rotationEffect(.init(degrees: 90))
                .padding(.top, 20)
                .padding(.trailing, 5)
        }
        .contentShape(RoundedRectangle(cornerRadius: 14))
        .contextMenu{
            Button(action: { homeViewModel.onRemoveReceiptTapped(receipt: receipt) }){
                Text("Delete")
            }
            Button(action: { homeViewModel.onReceiptTapped(receipt) }){
                Text("Edit")
            }
        }
    }
}
