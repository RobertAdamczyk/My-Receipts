//
//  Localized.swift
//  My Receipts
//
//  Created by Robert Adamczyk on 17.05.21.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
