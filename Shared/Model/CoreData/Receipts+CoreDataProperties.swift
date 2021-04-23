//
//  Receipts+CoreDataProperties.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//
//

import Foundation
import CoreData


extension Receipts {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipts> {
        return NSFetchRequest<Receipts>(entityName: "Receipts")
    }

    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var endOfWarranty: Date?

}

extension Receipts : Identifiable {

}
