//
//  AppImage.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 10.08.23.
//

import SwiftUI

enum AppImage: String {
    case scrollFill = "scroll.fill"
    case plusAppFill = "plus.app.fill"
    case gearshapeFill = "gearshape.fill"
    case checkmark = "checkmark"
    case xmark = "xmark"
    case chevronRight = "chevron.right"
    case photoFill = "photo.fill"
    case ellipsis = "ellipsis"
    case arrowDown = "arrow.down"
    case lineHorizontal = "line.horizontal.3"
    case squareArrowDown = "square.and.arrow.down"
    case plus = "plus"
}

func appImage(_ appImage: AppImage) -> Image {
    .init(systemName: appImage.rawValue)
}
