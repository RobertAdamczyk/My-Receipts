//
//  SettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 27.04.21.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {

    var generalDataSource: [Model] {
        return [.init(text: "Notifications", action: onNotificationsSettingsTapped),
                .init(text: "Categories", action: onCategoriesSettingsTapped)]
    }

    var appDataSource: [Model] {
        return [.init(text: "About", action: onAboutTapped)]
    }

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

extension SettingsViewModel {

    struct Model: Identifiable {
        let text: String
        let action: () -> Void

        var id: String {
            text
        }
    }
}
