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
            return (appText(.sortBy(.titleAscending)), true, "title")
        case .titleDescending:
            return (appText(.sortBy(.titleDescending)), false, "title")
        case .purchaseAscending:
            return (appText(.sortBy(.purchaseAscending)), true, "dateOfPurchase")
        case .purchaseDescending:
            return (appText(.sortBy(.purchaseDescending)), false, "dateOfPurchase")
        case .warrantyAscending:
            return (appText(.sortBy(.warrantyAscending)), true, "endOfWarranty")
        case .warrantyDescending:
            return (appText(.sortBy(.warrantyDescending)), false, "endOfWarranty")
        }
    }
}
