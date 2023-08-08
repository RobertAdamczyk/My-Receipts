//
//  NewReceipt.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct NewReceipt {
    var uiImage: UIImage? = nil
    var title: String = ""
    var dateOfPurchase: Date = .now
    var endOfWarranty: Date = Calendar.current.date(byAdding: .year, value: 2, to: Date()) ?? .now
    var categorie: Categorie? = nil

    init() {
        self.title = ""
        self.dateOfPurchase = .now
        self.endOfWarranty = Calendar.current.date(byAdding: .year, value: 2, to: Date()) ?? .now
    }

    init(receipt: Receipt) {
        self.categorie = receipt.categorie
        if let endOfWarranty = receipt.endOfWarranty {
            self.endOfWarranty = endOfWarranty
        }
        if let dateOfPurchase = receipt.dateOfPurchase {
            self.dateOfPurchase = dateOfPurchase
        }
        if let title = receipt.title {
            self.title = title
        }
        if let dataImage = receipt.image {
            self.uiImage = .init(data: dataImage)
        }
    }
}
