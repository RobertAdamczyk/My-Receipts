//
//  NotificationsSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 28.04.21.
//

import SwiftUI

struct NotificationsSettingsView: View {

    @StateObject var viewModel: NotificationsSettingsViewModel

    private var goToSettingsAttributedString: AttributedString {
        guard !viewModel.notificationAllowedToggle else { return .init("") }
        let highlighted = appText(.settings(.notificationsHintHightlighted))
        var attributedString = AttributedString(appText(.settings(.notificationsHint)) + " " + highlighted)
        guard let range = attributedString.range(of: highlighted) else { return .init("") }
        attributedString[range].foregroundColor = appColor(.darkBlue)
        attributedString[range].underlineStyle = .single
        return attributedString
    }

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        List {
            Section(header: Text(appText(.settings(.notificationsToggle))),
                    footer: Text(goToSettingsAttributedString)
                .onTapGesture(perform: viewModel.onGoToSettingsTapped)) {
                    Toggle(isOn: $viewModel.notificationAllowedToggle, label: {
                        Text(appText(.settings(.notificationsToggle)))
                            .apply(.regular, size: .M, color: .gray)
                    })
                    .disabled(true)
                    .onTapGesture(perform: viewModel.onToggleTapped)

                }
            
            Section(header: Text(appText(.settings(.notificationsOptions))),
                    footer: Text(appText(.settings(.notificationsDaysHint),
                                         args: viewModel.daysNotification.formatted()))){
                Picker(selection: $viewModel.daysNotification) {
                    ForEach(0..<51) { i in
                        Text("\(i)")
                    }
                } label: {
                    Text(appText(.settings(.notificationNotifyMe)))
                        .apply(.regular, size: .M, color: .gray)
                }

            }
        }
        .navigationTitle(appText(.settings(.notifications)))
        .onChange(of: viewModel.daysNotification) { _ in
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            viewModel.checkNotifications()
        }
        .onDisappear(perform: viewModel.onViewDisappear)
    }
}
