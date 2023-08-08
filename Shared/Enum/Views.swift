//
//  Views.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

enum Views: Equatable {

    static func == (lhs: Views, rhs: Views) -> Bool {
        switch (lhs, rhs) {
        case (.list, .list): return true
        case (.settings, .settings): return true
        default: return false
        }
    }

    case list
    case settings
}

enum StackView: Hashable {

    static func == (lhs: StackView, rhs: StackView) -> Bool {
        switch (lhs, rhs) {
        case (.selectCategorie, .selectCategorie): return true
        case (.warranty, .warranty): return true
        case (.categorieSettings, .categorieSettings): return true
        case (.notificationSettings, .notificationSettings): return true
        case (.infoSettings, .infoSettings): return true
        default: return false
        }
    }

    public func hash(into hasher: inout Hasher) {
        return hasher.combine(hashValue)
    }

    case selectCategorie(AddReceiptViewModel)
    case warranty(AddReceiptViewModel)
    case categorieSettings
    case notificationSettings
    case infoSettings
}

enum FullCoverSheet: Identifiable {
    case imagePreview(UIImage)
    case cameraView((Data) -> Void)
    case addReceipt(AddReceipt.Context)

    var id: String {
        switch self {
        case .imagePreview: return "001"
        case .cameraView: return "002"
        case .addReceipt: return "003"
        }
    }
}

enum StandardSheet: Identifiable {
    case sort((SortBy) -> Void)
    case imagePicker((UIImage) -> Void)
    case addCategorie((String, String) -> Void)

    var id: String {
        switch self {
        case .sort: return "001"
        case .imagePicker: return "002"
        case .addCategorie: return "003"
        }
    }
}
