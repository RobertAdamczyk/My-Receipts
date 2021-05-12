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
    @Published var categories: [Categorie] = []
    
    func fetchReceipts(){
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            receipts = try coreDataMenager.context.fetch(request)
        }catch let error {
            print("Error fetching Core Data. \(error)")
        }
        
        receipts = receipts.filter({ $0.categorie == nil })
    }
    
    func fetchCategories(){
        let request = NSFetchRequest<Categorie>(entityName: "Categorie")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            categories = try coreDataMenager.context.fetch(request)
        }catch let error {
            print("Error fetching Core Data. \(error)")
        }
    }
    
    func save() {
        coreDataMenager.save()
        fetchCategories()
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
    
    func removeReceiptInCategorie(at offsets: IndexSet, categorie: Categorie) {
        guard let receipts = categorie.receipts?.allObjects as? [Receipt] else { return }
        
        for index in offsets {
            let receipt = receipts[index]
            coreDataMenager.context.delete(receipt)
            if let id = receipt.id {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            }
            
            save()
        }
    }
    
    func removeCategorie(at offsets: IndexSet) {
        for index in offsets {
            let categorie = categories[index]
            coreDataMenager.context.delete(categorie)
            
            save()
        }
    }
    
    func addCategorie(title: String){
        let newCategorie = Categorie(context: CoreDataMenager.instance.context)
        newCategorie.title = title
        
        save()
    }
    
}
