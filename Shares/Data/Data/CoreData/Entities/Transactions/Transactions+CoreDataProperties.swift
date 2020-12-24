//
//  Transactions+CoreDataProperties.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 19/12/2563 BE.
//
//

import Foundation
import CoreData


extension Transactions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transactions> {
        return NSFetchRequest<Transactions>(entityName: "Transactions")
    }

    @NSManaged public var symbol: String?
    @NSManaged public var action: String?
    @NSManaged public var date: Date?
    @NSManaged public var price: String?
    @NSManaged public var size: String?
    @NSManaged public var commission: String?
    @NSManaged public var id: UUID?
    @NSManaged public var note: String?
}

extension Transactions : Identifiable {

}
