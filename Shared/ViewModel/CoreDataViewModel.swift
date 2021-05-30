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
    @Published var selectedCategorie: Categorie?
    
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
        if selectedCategorie == nil {
            filteredReceipts = receipts
            return
        }
        filteredReceipts = receipts.filter({ $0.categorie == selectedCategorie })
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
    
    func removeReceipt(receipt: Receipt) {
            coreDataMenager.context.delete(receipt)
            if let id = receipt.id {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            }
            
            save()
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
