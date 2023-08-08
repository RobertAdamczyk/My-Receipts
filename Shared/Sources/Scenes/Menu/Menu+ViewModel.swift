//
//  Menu+ViewModel.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 09.08.23.
//

import SwiftUI

final class MenuViewModel: ObservableObject {

    @Published var shouldShowMenu: Bool = false

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
