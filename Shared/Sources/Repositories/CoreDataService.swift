//
//  CoreDataService.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 06.08.23.
//

import CoreData

final class CoreDataService {

    @Published private(set) var receipts: [Receipt] = []
    @Published private(set) var categories: [Categorie] = []

    private(set) var sortBy: SortBy = .titleDescending

    private let container: NSPersistentCloudKitContainer
    private let context: NSManagedObjectContext

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
        updateReceipts()
        updateCategories()
    }

    func updateReceipts() {
        let request = NSFetchRequest<Receipt>(entityName: "Receipt")
        request.sortDescriptors = [NSSortDescriptor(key: sortBy.info.coreDataName, ascending: sortBy.info.ascending)]
        do {
            self.receipts = try context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error)")
        }
    }

    func updateCategories() {
        let request = NSFetchRequest<Categorie>(entityName: "Categorie")
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        do {
            self.categories = try context.fetch(request)
        } catch let error {
            print("Error fetching Core Data. \(error)")
        }
    }

    func setSortBy(_ sortBy: SortBy) {
        self.sortBy = sortBy
    }

    func addReceipt(title: String, dateOfPurchase: Date, endOfWarranty: Date?, categorie: Categorie?, imageData: Data?) -> Receipt {
        let receipt = Receipt(context: context)
        receipt.image = imageData
        receipt.title = title
        receipt.dateOfPurchase = dateOfPurchase
        receipt.endOfWarranty = endOfWarranty
        receipt.id = UUID()
        receipt.categorie = categorie

        save()

        return receipt
    }

    func editReceipt(editReceipt: Receipt?,
                     title: String, dateOfPurchase: Date, endOfWarranty: Date?, categorie: Categorie?, imageData: Data?) {
        editReceipt?.image = imageData
        editReceipt?.title = title
        editReceipt?.dateOfPurchase = dateOfPurchase
        editReceipt?.endOfWarranty = endOfWarranty
        editReceipt?.categorie = categorie

        save()
    }

    func removeReceipt(receipt: Receipt) {
        context.delete(receipt)
//        if let id = receipt.id {
//            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
//        }
        save()
    }

    func removeCategorie(at offsets: IndexSet, from categories: [Categorie]) {
        for index in offsets {
            let categorie = categories[index]
            context.delete(categorie)
            save()
        }
    }

    func addCategorie(title: String, symbol: String){
        let newCategorie = Categorie(context: context)
        newCategorie.title = title
        newCategorie.symbol = symbol
        save()
    }

    func save() {
        do {
            try context.save()
        } catch let error {
            print("Error saving Core Data. \(error)")
        }
    }
}
