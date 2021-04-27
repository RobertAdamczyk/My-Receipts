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
    @Published var showComponent: ShowComponents?
    
    func save(viewContext: NSManagedObjectContext) {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        
        let newData = Receipts(context: viewContext)
        newData.image = pickedImage
        newData.title = newReceipt.title
        newData.dateOfPurchase = newReceipt.dateOfPurchase
        newData.endOfWarranty = newReceipt.endOfWarranty
        newData.id = UUID()
        
        do {
            try viewContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func checkTitleAndImage() -> Bool { return newReceipt.title.count > 2 && newReceipt.image != nil }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        newReceipt.image = Image(uiImage: inputImage)
    }
    
    func showComponent(value: ShowComponents?) {
        withAnimation{
            showComponent = value == showComponent ? nil : value
        }
    }
}
