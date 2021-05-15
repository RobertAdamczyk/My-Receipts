//
//  SortBy.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 14.05.21.
//

import Foundation

enum SortBy: CaseIterable {
    case titleAscending
    case titleDescending
    case purchaseAscending
    case purchaseDescending
    case warrantyAscending
    case warrantyDescending
    
    var info: (name: String, ascending: Bool, coreDataName: String) {
        switch self {
        case .titleAscending:
            return ("Title (A-Z)", true, "title")
        case .titleDescending:
            return ("Title (Z-A)", false, "title")
        case .purchaseAscending:
            return ("Date of Purchase (Ascending)", true, "dateOfPurchase")
        case .purchaseDescending:
            return ("Date of Purchase (Descending)", false, "dateOfPurchase")
        case .warrantyAscending:
            return ("End of Warranty (Ascending)", true, "endOfWarranty")
        case .warrantyDescending:
            return ("End of Warranty (Descending)", false, "endOfWarranty")
        }
    }
}
