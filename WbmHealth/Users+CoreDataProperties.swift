//
//  Users+CoreDataProperties.swift
//  
//
//  Created by Zeeshan on 02/07/2019.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var firebaseToken: String?
    @NSManaged public var id: String?
    @NSManaged public var password: String?
    @NSManaged public var ssnId: String?
    @NSManaged public var token: String?
    @NSManaged public var profile_image: String?
    @NSManaged public var email: String?

}
