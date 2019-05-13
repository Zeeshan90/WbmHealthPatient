//
//  Test.swift
//  WbmHealth
//
//  Created by WBM on 5/6/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class Photo{
    
    var id : String!
    var contentType : String!
    var url : String!
     var data : String!
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        contentType = json["contentType"].stringValue
        url = json["url"].stringValue
        data = json["data"].stringValue
    }
    
    
    
}
