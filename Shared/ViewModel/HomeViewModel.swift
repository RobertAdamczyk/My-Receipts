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

    private let coordinator: Coordinator

    private var receiptsTask: Task<(), Never>?
    private var categoriesTask: Task<(), Never>?

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        receipts = coordinator.dependencies.coreDataService.receipts
        categories = coordinator.dependencies.coreDataService.categories
    }

    func onViewAppear() {
        updateReceipts()
        updateCategories()
        setupReceiptsObserver()
        setupCategoriesObserver()
    }

    func onViewDisappear() {
        receiptsTask?.cancel()
        receiptsTask = nil
        categoriesTask?.cancel()
        categoriesTask = nil
    }

    func onSortByTapped() {
        coordinator.presentStandardSheet(.sort({ [weak self] sortBy in
            self?.coordinator.dependencies.coreDataService.setSortBy(sortBy)
            self?.updateReceipts()
        }))
    }

    func onCategorieTapped(categorie: Categorie?) {
        self.selectedCategorie = categorie
        updateReceipts()
    }

    func onImageTapped(image: UIImage?) {
        guard let image else { return }
        coordinator.presentFullCoverSheet(.imagePreview(image))
    }

    func onReceiptTapped(_ receipt: Receipt) {
        coordinator.presentFullCoverSheet(.addReceipt(.edit(receipt)))
    }

    func onRemoveReceiptTapped(receipt: Receipt) {
        coordinator.dependencies.coreDataService.removeReceipt(receipt: receipt)
        updateReceipts()
    }

    private func setupReceiptsObserver() {
        receiptsTask?.cancel()
        receiptsTask = Task {
            for await receipts in coordinator.dependencies.coreDataService.$receipts.values {
                await MainActor.run {
                    if let selectedCategorie {
                        self.receipts = receipts.filter({ $0.categorie == selectedCategorie })
                    } else {
                        self.receipts = receipts
                    }
                }
            }
        }
    }

    private func setupCategoriesObserver() {
        categoriesTask?.cancel()
        categoriesTask = Task {
            for await categories in coordinator.dependencies.coreDataService.$categories.values {
                await MainActor.run {
                    self.categories = categories
                }
            }
        }
    }

    private func updateReceipts() {
        coordinator.dependencies.coreDataService.updateReceipts()
    }

    private func updateCategories() {
        coordinator.dependencies.coreDataService.updateCategories()
    }
}
