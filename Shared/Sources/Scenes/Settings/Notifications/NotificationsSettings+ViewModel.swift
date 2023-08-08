//
//  NotificationsSettings+ViewModel.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 09.08.23.
//

import SwiftUI

final class NotificationsSettingsViewModel: ObservableObject {

    @Published var notificationAllowedToggle = false
    @AppStorage("daysNotification") var daysNotification = 7

    private let coordinator: Coordinator

    private var permissionTask: Task<(), Never>?

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
        coordinator.dependencies.notificationsRepository.notificationRequest()
        setupNotificationsPermissionObserver()
    }

    func onViewDisappear() {
        permissionTask?.cancel()
        permissionTask = nil
    }

    func checkNotifications() {
        let receipts = coordinator.dependencies.coreDataService.receipts
        coordinator.dependencies.notificationsRepository.checkNotifications(array: receipts)
    }

    func onGoToSettingsTapped() {
        openSettings()
    }

    func onToggleTapped() {
        openSettings()
    }

    private func openSettings() {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }

    private func setupNotificationsPermissionObserver() {
        permissionTask = Task {
            for await newValue in coordinator.dependencies.notificationsRepository.$notificationAllowed.values {
                await MainActor.run {
                    self.notificationAllowedToggle = newValue
                }
            }
        }
    }
}
