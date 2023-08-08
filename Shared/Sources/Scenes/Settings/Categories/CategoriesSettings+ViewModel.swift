//
//  CategoriesSettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//

import Foundation

class CategoriesSettingsViewModel: ObservableObject {

    @Published private(set) var categories: [Categorie] = []

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        getCategories()
    }

    func onAddCategorieTapped() {
        coordinator.presentStandardSheet(.addCategorie({ [weak self] title, symbol in
            self?.coordinator.dependencies.coreDataService.addCategorie(title: title, symbol: symbol)
            self?.getCategories()
            self?.coordinator.dismiss()
        }))
    }

    func onRemoveCategorie(at offsets: IndexSet) {
        coordinator.dependencies.coreDataService.removeCategorie(at: offsets, from: categories)
        getCategories()
    }

    private func getCategories() {
        coordinator.dependencies.coreDataService.updateCategories()
        categories = coordinator.dependencies.coreDataService.categories
    }
}
