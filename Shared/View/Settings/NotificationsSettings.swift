//
//  NotificationsSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 28.04.21.
//

import SwiftUI

final class NotificationsSettingsViewModel: ObservableObject {

    @Published var notificationAllowed = false
    @AppStorage("daysNotification") var daysNotification = 7
    @AppStorage("notificationAllowedInApp") var notificationAllowedInApp = true

    private let coordinator: Coordinator

    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func checkNotifications() {
        let receipts = coordinator.dependencies.coreDataService.fetchReceipts(sortBy: .titleAscending)
        coordinator.dependencies.notificationsRepository.checkNotifications(array: receipts)
    }
}

struct NotificationsSettings: View {

    @StateObject var viewModel: NotificationsSettingsViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        List {
            if !viewModel.notificationAllowed {
                Section(header: Text("Info")){
                    VStack(spacing: 10){
                        HStack{
                            Spacer()
                            Text("❗️❗️❗️")
                            Spacer()
                        }
                        Text("You haven't allowed this app to show notifications.")
                        
                        Text("You can enable this functionality in IPhone:")
                        Text("Settings → My Receipts → Notifications → Allow")
                    }.font(.footnote)
                }
            }
            
            Section(header: Text("Enable Notifications")) {
                Toggle("Allow Notifications", isOn: $viewModel.notificationAllowedInApp)
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
        .onChange(of: viewModel.notificationAllowedInApp) { _ in
            viewModel.checkNotifications()
        }
    }
}
