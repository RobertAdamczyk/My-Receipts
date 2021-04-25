//
//  ReceiptViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.04.21.
//

import SwiftUI
import CoreData

class ReceiptViewModel : ObservableObject {
    
    
    func saveContext(viewContext: NSManagedObjectContext) {
        do {
            try viewContext.save()
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
