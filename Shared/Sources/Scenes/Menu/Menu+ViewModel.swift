//
//  Menu+ViewModel.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 09.08.23.
//

import SwiftUI

final class MenuViewModel: ObservableObject {

    @Published var shouldShowMenu: Bool = false

    var dataSource: [Model] {
        return [
            .init(image: .scrollFill, text: appText(.generic(.receipts)), action: onReceiptsTapped),
            .init(image: .plusAppFill, text: appText(.addReceipt(.newReceiptTitle)), action: onAddReceiptTapped),
            .init(image: .gearshapeFill, text: appText(.settings(.title)), action: onSettingsTapped)
        ]
    }

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        setupShowMenuObserver()
    }

    func setupShowMenuObserver() {
        Task {
            for await newValue in coordinator.$shouldShowMenu.values {
                await MainActor.run {
                    shouldShowMenu = newValue
                }
            }
        }
    }

    func onReceiptsTapped() {
        coordinator.hideMenu()
        coordinator.showTabView(.list)
    }

    func onAddReceiptTapped() {
        coordinator.hideMenu()
        coordinator.presentFullCoverSheet(.addReceipt(.new))
    }

    func onSettingsTapped() {
        coordinator.hideMenu()
        coordinator.showTabView(.settings)
    }

    func hideMenu() {
        coordinator.hideMenu()
    }
}

extension MenuViewModel {

    struct Model: Identifiable {
        let image: AppImage
        let text: String
        let action: () -> Void

        var id: String {
            text
        }
    }
}
