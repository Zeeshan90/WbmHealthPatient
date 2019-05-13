//
//  LabDetail.swift
//  WbmHealth
//
//  Created by WBM on 5/6/19.
//  Copyright © 2019 WBM. All rights reserved.
//


import Foundation
import SwiftyJSON


class Test{
    
    var v : Int!
    var id : String!
    var category : String!
    var performed : String!
    var photo : [Photo]!
    var rate : Int!
    var reportingDay : String!
    var sampleRequired : String!
    var testCode : String!
    var testName : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        v = json["__v"].intValue
        id = json["_id"].stringValue
        category = json["category"].stringValue
        performed = json["performed"].stringValue
        photo = [Photo]()
        let photoArray = json["photo"].arrayValue
        for photoJson in photoArray{
            let value = Photo(fromJson: photoJson)
            photo.append(value)
        }
        rate = json["rate"].intValue
        reportingDay = json["reportingDay"].stringValue
        sampleRequired = json["sampleRequired"].stringValue
        testCode = json["testCode"].stringValue
        testName = json["testName"].stringValue
    }
    
}

