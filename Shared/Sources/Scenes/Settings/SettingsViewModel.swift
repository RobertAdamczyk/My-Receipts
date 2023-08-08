//
//  SettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 27.04.21.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func onCategoriesSettingsTapped() {
        coordinator.pushView(.categorieSettings)
    }

    func onNotificationsSettingsTapped() {
        coordinator.pushView(.notificationSettings)
    }

    func onAboutTapped() {
        coordinator.pushView(.infoSettings)
    }
}
