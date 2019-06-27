//
//  LabTests+CoreDataProperties.swift
//  
//
//  Created by Zeeshan on 27/06/2019.
//
//

import Foundation
import CoreData


extension LabTests {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LabTests> {
        return NSFetchRequest<LabTests>(entityName: "LabTests")
    }

    @NSManaged public var id: String?
    @NSManaged public var testName: String?
    @NSManaged public var imgUrl: String?
    @NSManaged public var testCode: String?
    @NSManaged public var price: String?
    @NSManaged public var discount: String?

}
