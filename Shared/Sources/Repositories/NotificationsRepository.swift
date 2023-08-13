//
//  NotificationsRepository.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 06.08.23.
//

import SwiftUI

final class NotificationsRepository {

    @Published var notificationAllowed = false
    @AppStorage("daysNotification") var daysNotification = 7

    init() {
        setupDidBecomeActiveObserver()
    }

    func notificationRequest() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            self.notificationAllowed = granted

            if let error = error {
                self.notificationAllowed = false
                print(error.localizedDescription)
            }
        }
    }

    func checkNotifications(array: [Receipt]) {
        if !notificationAllowed {
            debugPrint("Notifications not allowed. Deleting all notifications...")
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            return
        }

        let receiptsWithWarranty = array.filter {
            guard let endOfWarranty = $0.endOfWarranty else { return false }
            return endOfWarranty > .now
        }

        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in
            if notifications.count == receiptsWithWarranty.count {
                debugPrint("Notifications Count OK !")
                return
            }else {
                debugPrint("Notifications Count \(notifications.count) NOT OK ! Creating notifications for \(receiptsWithWarranty.count) Receipts...")
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                for receipt in receiptsWithWarranty {
                    self.createNotification(for: receipt)
                }
                debugPrint("Notifications created.")
            }
        }
    }

    func createNotification(for receipt: Receipt){
        guard let endOfWarranty = receipt.endOfWarranty else { return }

        let content = UNMutableNotificationContent()
        guard let title = receipt.title else {
            print("Title error")
            return
        }
        content.title = title
        content.subtitle = appText(.generic(.notificationBody), args: daysNotification.formatted())
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current

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

    private func setupDidBecomeActiveObserver() {
        Task {
            for await _ in await NotificationCenter.default.notifications(named: UIApplication.didBecomeActiveNotification) {
                notificationRequest()
            }
        }
    }
}
