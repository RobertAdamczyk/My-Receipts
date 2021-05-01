//
//  SettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 27.04.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var notificationAllowed = false
    
    func notificationRequest(array: FetchedResults<Receipts>) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            
            DispatchQueue.main.async {
                self.notificationAllowed = success
                self.checkNotifications(array: array)
            }
            
            if let error = error {
                self.notificationAllowed = false
                print(error.localizedDescription)
            }
        }
    }
    
    func checkNotifications(array: FetchedResults<Receipts>) {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }
}
