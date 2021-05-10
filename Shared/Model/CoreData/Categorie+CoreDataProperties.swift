//
//  Categorie+CoreDataProperties.swift
//  My Receipts
//
//  Created by Robert Adamczyk on 10.05.21.
//
//

import Foundation
import CoreData


extension Categorie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Categorie> {
        return NSFetchRequest<Categorie>(entityName: "Categorie")
    }

    @NSManaged public var title: String?
    @NSManaged public var receipts: NSSet?

}

// MARK: Generated accessors for receipts
extension Categorie {

    @objc(addReceiptsObject:)
    @NSManaged public func addToReceipts(_ value: Receipt)

    @objc(removeReceiptsObject:)
    @NSManaged public func removeFromReceipts(_ value: Receipt)

    @objc(addReceipts:)
    @NSManaged public func addToReceipts(_ values: NSSet)

    @objc(removeReceipts:)
    @NSManaged public func removeFromReceipts(_ values: NSSet)

}
