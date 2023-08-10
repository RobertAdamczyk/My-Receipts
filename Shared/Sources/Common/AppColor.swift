//
//  AppColor.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 09.08.23.
//

import SwiftUI

enum AppColor: String {
    case shadow = "shadow"
    case background = "background"
    case darkBlue = "darkBlue"
    case hellBlue = "hellBlue"
    case gray = "grey"
    case yellow = "yellow"
    case white = "white"
    case black = "black"
    case red = "red"
}

enum AppGradient {

    case primary

    var gradient: Gradient {
        switch self {
        case .primary:
            return .init(stops: [.init(color: appColor(.hellBlue), location: 0),
                                 .init(color: appColor(.yellow), location: 1)])
        }
    }

    var startPoint: UnitPoint {
        switch self {
        case .primary: return .init(x: 0.22533334834366808, y: 0.20467034102585646)
        }
    }

    var endPoint: UnitPoint {
        switch self {
        case .primary: return .init(x: 1.05466673063715, y: 1.1854396050452791)
        }
    }
}

func appColor(_ color: AppColor) -> Color {
    return .init(color.rawValue)
}

func appGradient(_ appGradient: AppGradient) -> LinearGradient {
    return .init(stops: appGradient.gradient.stops,
                 startPoint: appGradient.startPoint,
                 endPoint: appGradient.endPoint)
}
