//
//  Receipts+CoreDataProperties.swift
//  My Receipts
//
//  Created by Robert Adamczyk on 27.04.21.
//
//

import Foundation
import CoreData


extension Receipts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipts> {
        return NSFetchRequest<Receipts>(entityName: "Receipts")
    }

    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var endOfWarranty: Date?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?

}
