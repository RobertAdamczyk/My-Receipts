//
//  SettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 27.04.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var notificationAllowed = false
    
    func notificationRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            
            DispatchQueue.main.async {
                self.notificationAllowed = success
            }
            
            if let error = error {
                self.notificationAllowed = false
                print(error.localizedDescription)
            }
        }
    }
}
