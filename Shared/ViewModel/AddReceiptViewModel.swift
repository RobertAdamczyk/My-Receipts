//
//  AddReceiptViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI
import CoreData

class AddReceiptViewModel: ObservableObject {
    @Published var inputImage: UIImage?
    @Published var newReceipt = NewReceipt()
    @AppStorage("daysNotification") var daysNotification = 7
    
    func save() {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        
        let newData = Receipt(context: CoreDataMenager.instance.context)
        newData.image = pickedImage
        newData.title = newReceipt.title
        newData.dateOfPurchase = newReceipt.dateOfPurchase
        newData.endOfWarranty = newReceipt.endOfWarranty
        newData.id = UUID()
        newData.categorie = newReceipt.categorie
        
        if let id = newData.id {
            createNotification(id: id)
        }
        
        CoreDataMenager.instance.save()
    }
    
    func createNotification(id: UUID){
        let content = UNMutableNotificationContent()
        content.title = newReceipt.title
        content.subtitle = "Za X dni skończy się gwaracja."
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        let dateNotification = newReceipt.endOfWarranty.addingTimeInterval(TimeInterval(daysNotification * 3600 * -24))

        dateComponents.day = Calendar.current.component(.day, from: dateNotification)
        dateComponents.month = Calendar.current.component(.month, from: dateNotification)
        dateComponents.year = Calendar.current.component(.year, from: dateNotification)
        dateComponents.hour = 22
        dateComponents.minute = 0
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func checkTitleAndImage() -> Bool { return newReceipt.title.count > 2 && newReceipt.image != nil }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        newReceipt.image = Image(uiImage: inputImage)
    }
}
