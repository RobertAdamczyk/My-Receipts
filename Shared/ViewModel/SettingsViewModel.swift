//
//  SettingsViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 27.04.21.
//

import SwiftUI

class SettingsViewModel: ObservableObject {
    @Published var notificationAllowed = false
    @AppStorage("daysNotification") var daysNotification = 7
    @AppStorage("notificationAllowedInApp") var notificationAllowedInApp = true
    
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
    
    func checkNotifications(array: [Receipt]) {
        if !notificationAllowedInApp{
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            return
        }
        
        if !notificationAllowed { return }
        
        let receiptsWithWarranty = array.filter({ $0.endOfWarranty != nil })
        
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            if notifications.count == receiptsWithWarranty.count {
                print("Notifications OK !!!")
                return
            }else {
                print("NOTIFICATION NOT OK \(notifications.count) != \(receiptsWithWarranty.count)")
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                for receipt in array {
                    self.addNotification(receipt: receipt)
                }
            }
        }
    }
    
    func addNotification(receipt: Receipt){
        if !notificationAllowedInApp { return }
        
        let content = UNMutableNotificationContent()
        guard let title = receipt.title else {
            print("Title error")
            return
        }
        content.title = title
        content.subtitle = "The guarantee will expire in \(daysNotification) days.".localized()
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        guard let endOfWarranty = receipt.endOfWarranty else {
            print("EndOfWarranty error \(title)")
            return
        }
        let dateNotification = endOfWarranty.addingTimeInterval(TimeInterval(daysNotification * 3600 * -24))

        dateComponents.day = Calendar.current.component(.day, from: dateNotification)
        dateComponents.month = Calendar.current.component(.month, from: dateNotification)
        dateComponents.year = Calendar.current.component(.year, from: dateNotification)
        dateComponents.hour = 20
        dateComponents.minute = 0
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // choose a random identifier
        guard let id = receipt.id else {
            print("ID error")
            return
        }
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}
