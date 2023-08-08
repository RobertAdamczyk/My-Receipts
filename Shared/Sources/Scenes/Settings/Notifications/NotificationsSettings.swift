//
//  NotificationsSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 28.04.21.
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

struct NotificationsSettings: View {

    @StateObject var viewModel: NotificationsSettingsViewModel

    private var goToSettingsAttributedString: AttributedString {
        guard !viewModel.notificationAllowedToggle else { return .init("") }
        let goToSettings = "Go to settings"
        var attributedString = AttributedString("You haven't allowed this app to show notifications. You can enable this functionality in settings." + " " + goToSettings)
        guard let range = attributedString.range(of: goToSettings) else { return .init("") }
        attributedString[range].foregroundColor = .blue
        attributedString[range].underlineStyle = .single
        return attributedString
    }

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        List {
            Section(header: Text("Enable Notifications"),
                    footer: Text(goToSettingsAttributedString)
                .font(.footnote)
                .onTapGesture(perform: viewModel.onGoToSettingsTapped)) {
                Toggle("Allow Notifications", isOn: $viewModel.notificationAllowedToggle)
                        .disabled(true)
                        .onTapGesture(perform: viewModel.onToggleTapped)
            }
            
            Section(header: Text("Notification Options"), footer: Text("The alert will come \(viewModel.daysNotification) days before the guarantee expires.")){
                Picker("Notify me before", selection: $viewModel.daysNotification) {
                    ForEach(0..<51) { i in
                        Text("\(i)")
                    }
                }
            }
        
            
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("Notifications")
        .onChange(of: viewModel.daysNotification) { _ in
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            viewModel.checkNotifications()
        }
        .onDisappear(perform: viewModel.onViewDisappear)
    }
}
