//
//  ReceiptRow.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 24.04.21.
//

import SwiftUI

struct ReceiptRow: View {
    var receipt: Receipts
    var body: some View {
        HStack{
            ZStack{
                Color("Light")
                    .frame(width: 50, height: 80)
                    .cornerRadius(5)
                if let dataImage = receipt.image {
                    if let uiimage = UIImage(data: dataImage) {
                        Image(uiImage: uiimage)
                            .resizable()
                            .frame(width: 50, height: 80)
                            .cornerRadius(5)
                    }
                }
            }
            
                
            VStack(alignment: .leading, spacing: 5) {
                Text("\(receipt.title!)")
                    .font(.title3)
                    .fontWeight(.medium)
                Text("Purchase: \(receipt.dateOfPurchase!, style: .date)")
                Text("Warranty to: \(receipt.endOfWarranty!, style: .date)")
            }
        }
    }
}
