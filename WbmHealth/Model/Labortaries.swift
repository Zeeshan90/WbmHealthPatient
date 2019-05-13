//
//  Labortaries.swift
//  WbmHealth
//
//  Created by WBM on 5/2/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class Labortaries{
    
    var id : String!
    var laboratoryName : String!
    var photo : [AnyObject]!
    var image: String?
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        laboratoryName = json["laboratoryName"].stringValue
        
        photo = [Int]() as [AnyObject]
        let photoArray = json["photo"].arrayValue
        print(photoArray)
        for photoJson in photoArray{
            image = photoJson["url"].stringValue
            photo.append(photoJson["url"].string as AnyObject)
        }
    }
    
}
