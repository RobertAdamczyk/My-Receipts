//
//  AddReceiptViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI
import CoreData

class AddReceiptViewModel: ObservableObject {

    @Published var newReceipt = NewReceipt()
    @Published var warranty = false

    @AppStorage("daysNotification") var daysNotification = 7

    @Published private(set) var categories: [Categorie] = []

    var navigationTitle: String {
        switch context {
        case .new: return "New Receipt".localized()
        case .edit: return "Edit Receipt".localized()
        }
    }

    var meetsRequirementsToCreateReceipt: Bool {
        newReceipt.title.count > 2 && newReceipt.uiImage != nil
    }

    let context: AddReceipt.Context

    /// Data of image to save in core data
    private var imageData: Data? {
        return newReceipt.uiImage?.jpegData(compressionQuality: 1.0)
    }

    /// Indicate first open of add receipt view
    private var initialViewAppear: Bool = true

    private let coordinator: Coordinator
    private let parentCoordinator: Coordinator

    init(coordinator: Coordinator, parentCoordinator: Coordinator, context: AddReceipt.Context) {
        self.coordinator = coordinator
        self.parentCoordinator = parentCoordinator
        self.context = context
        self.categories = coordinator.dependencies.coreDataService.categories
        if case .edit(let receipt) = context {
            newReceipt = .init(receipt: receipt)
            warranty = receipt.endOfWarranty != nil
        }
    }

    func onViewAppear() {
        if initialViewAppear {
            coordinator.presentDialogApp(.loadPhoto({ [weak self] in
                self?.showCamera()
            }, { [weak self] in
                self?.showImagePicker()
            }))
        }
        initialViewAppear = false
    }

    func onCloseButtonTapped() {
        parentCoordinator.dismiss()
    }

    func onImageTapped() {
        coordinator.presentDialogApp(.loadPhoto({ [weak self] in
            self?.showCamera()
        }, { [weak self] in
            self?.showImagePicker()
        }))
    }

    func onSaveButtonTapped() {
        if meetsRequirementsToCreateReceipt {
            switch context {
            case .new: addReceipt()
            case .edit(let receipt): saveReceipt(receipt: receipt)
            }
            parentCoordinator.dependencies.coreDataService.updateReceipts()
            parentCoordinator.dismiss()
        }
    }

    private func showCamera() {
        coordinator.presentFullCoverSheet(.cameraView( { [weak self] data in
            self?.newReceipt.uiImage = UIImage(data: data)
        }))
    }

    private func showImagePicker() {
        coordinator.presentStandardSheet(.imagePicker( { [weak self] uiimage in
            self?.newReceipt.uiImage = uiimage
        }))
    }
    
    private func addReceipt() {
        let receipt = coordinator.dependencies.coreDataService.addReceipt(title: newReceipt.title,
                                                                          dateOfPurchase: newReceipt.dateOfPurchase,
                                                                          endOfWarranty: warranty ? newReceipt.endOfWarranty : nil,
                                                                          categorie: newReceipt.categorie,
                                                                          imageData: imageData)
        coordinator.dependencies.notificationsRepository.createNotification(for: receipt)
    }
    
    private func saveReceipt(receipt: Receipt) {
        coordinator.dependencies.coreDataService.editReceipt(editReceipt: receipt,
                                                             title: newReceipt.title,
                                                             dateOfPurchase: newReceipt.dateOfPurchase,
                                                             endOfWarranty: warranty ? newReceipt.endOfWarranty : nil,
                                                             categorie: newReceipt.categorie,
                                                             imageData: imageData)
        if let id = receipt.id {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            if warranty {
                coordinator.dependencies.notificationsRepository.createNotification(for: receipt)
            }
            
            if let uiimage = newReceipt.uiImage {
                CacheImage.shared.set(forKey: id.uuidString, image: uiimage)
            }
        }
    }
}
