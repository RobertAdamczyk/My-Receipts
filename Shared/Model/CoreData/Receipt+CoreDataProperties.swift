//
//  Receipt+CoreDataProperties.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 10.05.21.
//
//

import Foundation
import CoreData


extension Receipt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Receipt> {
        return NSFetchRequest<Receipt>(entityName: "Receipt")
    }

    @NSManaged public var dateOfPurchase: Date?
    @NSManaged public var endOfWarranty: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?
    @NSManaged public var categorie: Categorie?

}

extension Receipt : Identifiable {

}
