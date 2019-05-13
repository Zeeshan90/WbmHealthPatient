//
//  LabDetail.swift
//  WbmHealth
//
//  Created by WBM on 5/6/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON

class LabDetail {
    var id : String!
    var cost : Int!
    var descriptionField : String!
    var discount : Int!
    var price : Int!
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
        cost = json["cost"].intValue
        descriptionField = json["description"].stringValue
        discount = json["discount"].intValue
        price = json["price"].intValue
        rate = json["rate"].intValue
        let testsJson = json["tests"]
        if !testsJson.isEmpty{
            tests = Test(fromJson: testsJson)
        }
    }
}
