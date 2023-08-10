//
//  FontStyle.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 09.08.23.
//

import Foundation
import SwiftUI

enum FontStyle {

    case regular
    case medium

    enum AppFont: String {
        case robotoMedium = "Roboto-Medium"
        case robotoRegular = "Roboto-Regular"
    }

    var font: AppFont {
        switch self {
        case .regular: return .robotoRegular
        case .medium: return .robotoMedium
        }
    }

    func makeFontStyle(size: Size, scaling: Scaling) -> Font {
        switch scaling {
        case .dynamic: return .custom(font.rawValue, size: size.value)
        case .fixed: return .custom(font.rawValue, fixedSize: size.value)
        }
    }
}

extension FontStyle {

    enum Size {
        case XS
        case S
        case M
        case L
        case H1

        var value: CGFloat {
            switch self {
            case .XS: return 10
            case .S: return 14
            case .M: return 16
            case .L: return 18
            case .H1: return 32
            }
        }
    }

    enum Scaling {
        case dynamic
        case fixed
    }
}

extension View {

    func apply(_ fontStyle: FontStyle, size: FontStyle.Size,
               color: AppColor, scaling: FontStyle.Scaling = .dynamic) -> some View {
        self
            .font(fontStyle.makeFontStyle(size: size, scaling: scaling))
            .foregroundColor(appColor(color))
    }
}
