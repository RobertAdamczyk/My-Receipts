//
//  ReceiptRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ReceiptRow: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @State var image : Image?
    @State var uiimage: UIImage?
    var receipt: Receipts
    var body: some View {
        HStack(spacing: 10){
            ZStack{
                if let unwarppedImage = image {
                    unwarppedImage
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50)
                        .cornerRadius(5)
                        .onTapGesture{
                            withAnimation{
                                homeViewModel.selectedImage = uiimage
                            }
                        }
                }else {
                    Color("Light")
                        .frame(width: 50, height: 67)
                        .cornerRadius(5)
                }
            }.onAppear(){
                if let im = CacheImage.shared.get(forKey: receipt.id?.uuidString ?? ""){
                    image = Image(uiImage: im)
                    uiimage = im
                    return
                }
                guard let dataImage = receipt.image else { return }
                guard let unwrappedUIImage = UIImage(data: dataImage) else { return }
                
                CacheImage.shared.set(forKey: receipt.id?.uuidString ?? "", image: unwrappedUIImage)
                image = Image(uiImage: unwrappedUIImage)
                uiimage = unwrappedUIImage
            }
            
                
            VStack(alignment: .leading, spacing: 5) {
                if let title = receipt.title {
                    Text("\(title)")
                        .font(.title3)
                        .fontWeight(.medium)
                        .lineLimit(1)
                        .minimumScaleFactor(0.7)
                }
                if let purchase = receipt.dateOfPurchase {
                    Text("Purchase: \(purchase, style: .date)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                if let warranty = receipt.endOfWarranty {
                    Text("Warranty to: \(warranty, style: .date)")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}
