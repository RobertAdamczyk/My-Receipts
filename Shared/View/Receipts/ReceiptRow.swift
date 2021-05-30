//
//  ReceiptRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ReceiptRow: View {
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var coreData: CoreDataViewModel
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
                            withAnimation{
                                homeViewModel.selectedImage = uiimage
                            }
                        }
                }else {
                    Color("Light")
                        .frame(width: 50, height: 67)
                        .cornerRadius(5)
                }
            }
            .padding(.horizontal, 10)
            .onAppear(){
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
            VStack(alignment: .leading, spacing: 8){
                if let title = receipt.title {
                    Text(title)
                        .font(.custom("Roboto Medium", size: 16))
                        .fontWeight(.semibold)
                }
                if let purchase = receipt.dateOfPurchase {
                    Text("Purchase: \(purchase, style: .date)")
                        .font(.custom("Roboto Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                }
                if let warranty = receipt.endOfWarranty {
                    Text("Guarantee: \(warranty, style: .date)")
                        .font(.custom("Roboto Medium", size: 12))
                        .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                }
                
            }
            Spacer()
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                .shadow(color: Color("ShadowColor"), radius:8, x:0, y:0)
        )
        .overlay(Image(systemName: "ellipsis")
                    .font(.title2)
                    .rotationEffect(.init(degrees: 90))
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .padding(.trailing, 5), alignment: .topTrailing)
        .contentShape(RoundedRectangle(cornerRadius: 14))
        .contextMenu{
            Button(action:{
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    withAnimation{
                        coreData.removeReceipt(receipt: receipt)
                    }
                }
                
                
            }){
                Text("Delete").foregroundColor(.red)
            }
        }
    }
}
