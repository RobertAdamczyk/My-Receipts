//
//  CategoriesSettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import Foundation

class CategoriesSettingsViewModel: ObservableObject {
    @Published var addingCategorie = false
    @Published var title = ""
}
