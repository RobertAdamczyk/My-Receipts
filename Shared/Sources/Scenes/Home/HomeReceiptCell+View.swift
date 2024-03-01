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

    @State private var isConfirmationDialogPresented: Bool = false

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
                    appColor(.gray)
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
                    Text(appText(.generic(.purchaseDate)) + ": \(purchase.formatted(date: .long, time: .omitted))")
                        .apply(.regular, size: .S, color: .gray)
                }
                if let warranty = receipt.endOfWarranty {
                    Text(appText(.generic(.warranty)) + ": \(warranty.formatted(date: .long, time: .omitted))")
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
            Button(action: {
                isConfirmationDialogPresented = true
            }, label: {
                appImage(.ellipsis)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24)
                    .foregroundStyle(appColor(.darkBlue))
                    .rotationEffect(.init(degrees: 90))
                    .padding(.top, 20)
                    .padding(.trailing, 5)
            })
        }
        .contentShape(RoundedRectangle(cornerRadius: 14))
        .contextMenu{
            Button(action: { homeViewModel.onReceiptTapped(receipt) }){
                Text(appText(.generic(.edit)))
            }
            Button(role: .destructive, action: { homeViewModel.onRemoveReceiptTapped(receipt: receipt) }){
                Text(appText(.generic(.delete)))
            }
        }
        .confirmationDialog("", isPresented: $isConfirmationDialogPresented, titleVisibility: .hidden) {
            Button(action: {
                homeViewModel.onReceiptTapped(receipt)
            }, label: {
                Text(appText(.generic(.edit)))
            })
            Button(role: .destructive, action: {
                homeViewModel.onRemoveReceiptTapped(receipt: receipt)
            }, label: {
                Text(appText(.generic(.delete)))
            })
        }
    }
}
