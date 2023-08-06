//
//  HomeViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

final class HomeViewModel: ObservableObject {

    @Published var receipts: [Receipt] = []
    @Published var categories: [Categorie] = []
    @Published var selectedCategorie: Categorie?

    @Published var sortBy: SortBy = SortBy.titleAscending

    var allReceiptsCount: Int {
        coordinator.dependencies.coreDataService.fetchReceipts(sortBy: .titleAscending).count
    }

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func onViewAppear() {
        getReceipts()
        getCategories()
    }

    func onSortByTapped() {
        coordinator.presentStandardSheet(.sort({ [weak self] sortBy in
            self?.sortBy = sortBy
            self?.getReceipts()
        }))
    }

    func onCategorieTapped(categorie: Categorie?) {
        self.selectedCategorie = categorie
        getReceipts()
    }

    func onImageTapped(image: UIImage?) {
        guard let image else { return }
        coordinator.presentFullCoverSheet(.imagePreview(image))
    }

    func onReceiptTapped(_ receipt: Receipt) {
        coordinator.presentFullCoverSheet(.addReceipt(.edit(receipt)))
    }

    func onRemoveReceiptTapped(receipt: Receipt) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) { [weak self] in
            withAnimation {
                self?.coordinator.dependencies.coreDataService.removeReceipt(receipt: receipt)
                self?.getReceipts()
            }
        }
    }

    private func getReceipts() {
        let allReceipts = coordinator.dependencies.coreDataService.fetchReceipts(sortBy: sortBy)
        guard let selectedCategorie else {
            self.receipts = allReceipts
            return
        }
        self.receipts = allReceipts.filter({ $0.categorie == selectedCategorie })
    }

    private func getCategories() {
        self.categories = coordinator.dependencies.coreDataService.fetchCategories()
    }
}
