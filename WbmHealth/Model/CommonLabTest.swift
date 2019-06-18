//
//  CommonLabTest.swift
//  WbmHealth
//
//  Created by Zeeshan on 11/06/2019.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON

class CommonLabTest{
    
    
    var id : String!
    var labTests : [AnyObject]!
    var descriptionField : String!
    var discount : Int!
    var price : Int!
    var promotion : String!
    var rate : Int!
    var tests : Test!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        labTests = [AnyObject]()
        let labTestsArray = json["labTests"].arrayValue
        for labTestsJson in labTestsArray{
            id = labTestsJson["_id"].stringValue
            descriptionField = labTestsJson["description"].stringValue
            discount = labTestsJson["discount"].intValue
            price = labTestsJson["price"].intValue
            promotion = labTestsJson["promotion"].stringValue
            rate = labTestsJson["rate"].intValue
            let testsJson = labTestsJson["tests"]
            if !testsJson.isEmpty{
                tests = Test(fromJson: testsJson)
            }
            
        }

}





}

