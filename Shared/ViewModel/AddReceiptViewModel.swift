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
    @Published var warranty = false
    @Published var loadedReceipt = false
    
    func save() {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        
        let newData = Receipt(context: CoreDataMenager.instance.context)
        newData.image = pickedImage
        newData.title = newReceipt.title
        newData.dateOfPurchase = newReceipt.dateOfPurchase
        newData.endOfWarranty = warranty ? newReceipt.endOfWarranty : nil
        newData.id = UUID()
        newData.categorie = newReceipt.categorie
        
        if let id = newData.id {
            createNotification(id: id)
        }
        CoreDataMenager.instance.save()
    }
    
    func edit(editReceipt: Receipt?) {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        
        editReceipt?.image = pickedImage
        editReceipt?.title = newReceipt.title
        editReceipt?.dateOfPurchase = newReceipt.dateOfPurchase
        editReceipt?.endOfWarranty = warranty ? newReceipt.endOfWarranty : nil
        editReceipt?.categorie = newReceipt.categorie
        
        if let id = editReceipt?.id {
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            if warranty {
                createNotification(id: id)
            }
            
            if let inputImage = inputImage {
                CacheImage.shared.set(forKey: id.uuidString, image: inputImage)
            }
        }
        
        
        
        CoreDataMenager.instance.save()
    }
    
    func loadReceipt(editReceipt: Receipt?){
        if let editReceipt = editReceipt{
            if loadedReceipt { return }
            newReceipt.categorie = editReceipt.categorie
            if let endOfWarranty = editReceipt.endOfWarranty {
                newReceipt.endOfWarranty = endOfWarranty
                warranty = true
            }
            
            guard let dateOfPurchase = editReceipt.dateOfPurchase else { return }
            newReceipt.dateOfPurchase = dateOfPurchase
            guard let title = editReceipt.title else { return }
            newReceipt.title = title
            
            guard let dataImage = editReceipt.image else { return }
            guard let unwrappedUIImage = UIImage(data: dataImage) else { return }
            newReceipt.image = Image(uiImage: unwrappedUIImage)
            inputImage = unwrappedUIImage
            loadedReceipt = true
        }
    }
    
    func createNotification(id: UUID){
        let content = UNMutableNotificationContent()
        content.title = newReceipt.title
        content.subtitle = "The guarantee will expire in \(daysNotification) days.".localized()
        content.sound = UNNotificationSound.default

        // show this notification five seconds from now
        var dateComponents = DateComponents()
        dateComponents.calendar = Calendar.current
        
        let dateNotification = newReceipt.endOfWarranty.addingTimeInterval(TimeInterval(daysNotification * 3600 * -24))

        dateComponents.day = Calendar.current.component(.day, from: dateNotification)
        dateComponents.month = Calendar.current.component(.month, from: dateNotification)
        dateComponents.year = Calendar.current.component(.year, from: dateNotification)
        dateComponents.hour = 20
        dateComponents.minute = 0
        // Create the trigger as a repeating event.
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

        let request = UNNotificationRequest(identifier: id.uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func checkTitleAndImage() -> Bool { return newReceipt.title.count > 2 && newReceipt.image != nil }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        newReceipt.image = Image(uiImage: inputImage)
    }
}
