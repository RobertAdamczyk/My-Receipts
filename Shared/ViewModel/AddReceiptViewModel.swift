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
    
    func save(viewContext: NSManagedObjectContext) {
        let pickedImage = inputImage?.jpegData(compressionQuality: 1.0)
        
        let newData = Receipts(context: viewContext)
        newData.image = pickedImage
        newData.title = "test"
        
        do {
            try viewContext.save()
        }
        catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        newReceipt.image = Image(uiImage: inputImage)
    }
}
