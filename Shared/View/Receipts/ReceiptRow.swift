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
                .shadow(color: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2048044233)), radius:8, x:0, y:0)
        )
//        .overlay(
//            Button(action:{
//                
//            }){
//                Text("Show")
//                    .font(.custom("Roboto Medium", size: 14))
//                    .fontWeight(.semibold)
//                    .padding(5)
//                    .padding(.horizontal, 5)
//                    .background(
//                        RoundedRectangle(cornerRadius: 9)
//                            .fill(Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)))
//                    )
//            }
//            .padding(10)
//            .padding(.trailing, 10)
//            , alignment: .bottomTrailing
//        )
        .overlay(Image(systemName: "ellipsis")
                    .font(.title2)
                    .rotationEffect(.init(degrees: 90))
                    .foregroundColor(.secondary)
                    .padding(.top, 20)
                    .padding(.trailing, 5), alignment: .topTrailing)
//        HStack(spacing: 10){
//            ZStack{
//                if let unwarppedImage = image {
//                    unwarppedImage
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 50)
//                        .cornerRadius(5)
//                        .onTapGesture{
//                            withAnimation{
//                                homeViewModel.selectedImage = uiimage
//                            }
//                        }
//                }else {
//                    Color("Light")
//                        .frame(width: 50, height: 67)
//                        .cornerRadius(5)
//                }
//            }.onAppear(){
//                if let im = CacheImage.shared.get(forKey: receipt.id?.uuidString ?? ""){
//                    image = Image(uiImage: im)
//                    uiimage = im
//                    return
//                }
//                guard let dataImage = receipt.image else { return }
//                guard let unwrappedUIImage = UIImage(data: dataImage) else { return }
//
//                CacheImage.shared.set(forKey: receipt.id?.uuidString ?? "", image: unwrappedUIImage)
//                image = Image(uiImage: unwrappedUIImage)
//                uiimage = unwrappedUIImage
//            }
//
//
//            VStack(alignment: .leading, spacing: 5) {
//                if let title = receipt.title {
//                    Text("\(title)")
//                        .font(.title3)
//                        .fontWeight(.medium)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.7)
//                }
//                if let purchase = receipt.dateOfPurchase {
//                    Text("Purchase: \(purchase, style: .date)")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//                if let warranty = receipt.endOfWarranty {
//                    Text("Warranty to: \(warranty, style: .date)")
//                        .font(.caption)
//                        .foregroundColor(.secondary)
//                }
//            }
//        }
    }
}
