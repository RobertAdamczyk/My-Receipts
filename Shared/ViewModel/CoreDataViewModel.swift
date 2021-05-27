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
    @Published var filteredReceipts: [Receipt] = []
    @Published var filteredReceiptsInCategorie: [Receipt] = []
    
    @Published var sortBy: SortBy = SortBy.titleAscending
    
    init(){
        fetchCategories()
        fetchReceipts()
    }
    
    func fetchReceipts(){
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [NSSortDescriptor(key: sortBy.info.coreDataName, ascending: sortBy.info.ascending)]
        do {
            receipts = try coreDataMenager.context.fetch(request)
            filterReceipts()
        }catch let error {
            print("Error fetching Core Data. \(error)")
        }
    }
    
    func filterReceipts(){
        filteredReceipts = receipts.filter({ $0.categorie == nil })
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
    
    func fetchReceiptsInCategorie(categorie: Categorie){
        if let receipts = categorie.receipts?.allObjects as? [Receipt] {
            switch sortBy {
            case .titleAscending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.title ?? "" < $1.title ?? "" })
            case .titleDescending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.title ?? "" > $1.title ?? "" })
            case .purchaseAscending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.dateOfPurchase ?? Date() < $1.dateOfPurchase ?? Date() })
            case .purchaseDescending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.dateOfPurchase ?? Date() > $1.dateOfPurchase ?? Date() })
            case .warrantyAscending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.endOfWarranty ?? Date() < $1.endOfWarranty ?? Date() })
            case .warrantyDescending:
                filteredReceiptsInCategorie = receipts.sorted(by: { $0.endOfWarranty ?? Date() > $1.endOfWarranty ?? Date() })
            }
            
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
        for index in offsets {
            let receipt = filteredReceiptsInCategorie[index]
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
    
    func addCategorie(title: String, symbol: String){
        let newCategorie = Categorie(context: CoreDataMenager.instance.context)
        newCategorie.title = title
        newCategorie.symbol = symbol
        
        save()
    }
    
}
