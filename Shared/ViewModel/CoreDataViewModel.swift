//
//  CoreDataViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 06.05.21.
//

import SwiftUI
import CoreData

class CoreDataViewModel: ObservableObject {
    let coreDataMenager = CoreDataMenager.instance
    @Published var receipts: [Receipt] = []
    
    init() {
        fetchReceipts()
    }
    
    func fetchReceipts(){
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            receipts = try coreDataMenager.context.fetch(request)
        }catch let error {
            print("Error fetching Core Data. \(error)")
        }
        
    }
    
    func save() {
        coreDataMenager.save()
        fetchReceipts()
    }
    
    func removeReceipt(at offsets: IndexSet) {
        for index in offsets {
            let receipt = receipts[index]
            coreDataMenager.context.delete(receipt)
            if let id = receipt.id {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            }
            
            save()
        }
    }
    
}