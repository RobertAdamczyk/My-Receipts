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

enum StackView {
    case categorie
    case gwaranty
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
