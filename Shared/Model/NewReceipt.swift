//
//  NewReceipt.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct NewReceipt {
    var image: Image?
    var title: String
    var dateOfPurchase: Date
    var endOfWarranty: Date
    
    init(){
        title = ""
        dateOfPurchase = Date()
        endOfWarranty = Calendar.current.date(byAdding: .year, value: 2, to: Date()) ?? Date()
    }
}
