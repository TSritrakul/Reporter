//
//  Profile+CoreDataProperties.swift
//  Data
//
//  Created by Thatchaphon Sritrakul on 17/12/2563 BE.
//
//

import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var userID: String?

}

extension Profile : Identifiable {

}
