//
//  CoreDataMenager.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 06.05.21.
//

import SwiftUI
import CoreData

class CoreDataMenager {
    static let instance = CoreDataMenager()
    let container: NSPersistentCloudKitContainer
    let context: NSManagedObjectContext
    
    init(){
        container = NSPersistentCloudKitContainer(name: "My_Receipts")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading Core Data. \(error)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        context = container.viewContext
    }
    
    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data. \(error)")
        }
    }
}
