//
//  ViewFactory.swift
//  Receipts Store
//
//  Created by Robert Adamczyk on 06.08.23.
//

import SwiftUI

struct FullCoverSheetView: View {

    @StateObject var coordinator: Coordinator

    init(fullCoverSheet: FullCoverSheet, parentCoordinator: Coordinator) {
        self.fullCoverSheet = fullCoverSheet
        self.parentCoordinator = parentCoordinator
        self._coordinator = .init(wrappedValue: .init(dependencies: parentCoordinator.dependencies))
    }

    let fullCoverSheet: FullCoverSheet
    let parentCoordinator: Coordinator

    var body: some View {
        NavigationStack(path: $coordinator.stackedViews) {
            makeFullCoverSheet(fullCoverSheet)
                .navigationDestination(for: StackView.self) {
                    DestinationView(stackView: $0, coordinator: coordinator)
                }
        }
        .dialogApp(item: $coordinator.presentedDialogApp)
        .fullScreenCover(item: $coordinator.presentedFullCoverSheet) {
            FullCoverSheetView(fullCoverSheet: $0, parentCoordinator: coordinator)
        }
        .sheet(item: $coordinator.presentedStandardSheet) {
            StandardSheetView(standardSheet: $0, parentCoordinator: coordinator)
        }
    }

    @ViewBuilder
    private func makeFullCoverSheet(_ fullCoverSheet: FullCoverSheet) -> some View {
        switch fullCoverSheet {
        case .imagePreview(let image): ImagePreviewView(uiImage: image, parentCoordinator: parentCoordinator)
        case .cameraView(let completion): ImagePickerView(parentCoordinator: parentCoordinator,
                                                          sourceType: .camera, completion: completion)
        case .addReceipt(let context): AddReceipt(coordinator: coordinator, parentCoordinator: parentCoordinator, context: context)
        }
    }
}

struct StandardSheetView: View {

    let standardSheet: StandardSheet
    let parentCoordinator: Coordinator

    var body: some View {
        makeStandardSheet(standardSheet)
    }

    @ViewBuilder
    private func makeStandardSheet(_ standardSheet: StandardSheet) -> some View {
        switch standardSheet {
        case .sort(let completion): SortByView(completion: completion)
                .presentationDetents([.fraction(0.35)])
        case .imagePicker(let completion): ImagePickerView(parentCoordinator: parentCoordinator,
                                                           sourceType: .photoLibrary, completion: completion)
        case .addCategorie(let completion): AddCategorieView(completion: completion)
        }
    }
}

struct DestinationView: View {

    let stackView: StackView
    let coordinator: Coordinator

    var body: some View {
        makeDestination(stackView)
    }

    @ViewBuilder
    private func makeDestination(_ view: StackView) -> some View {
        switch view {
        case .selectCategorie(let viewModel): AddReceiptCategorie(viewModel: viewModel)
        case .warranty(let viewModel): AddReceiptWarrantyView(viewModel: viewModel)
        case .categorieSettings: CategoriesSettingsView(coordinator: coordinator)
        case .notificationSettings: NotificationsSettingsView(coordinator: coordinator)
        case .infoSettings: AboutView()
        }
    }
}
