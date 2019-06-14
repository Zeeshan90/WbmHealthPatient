//
//  Reason.swift
//  WbmHealth
//
//  Created by WBM on 5/29/19.
//  Copyright © 2019 WBM. All rights reserved.
//

import Foundation
import SwiftyJSON


class Reason{
    
    var id : String!
    var text : String!
    
    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["_id"].stringValue
        text = json["text"].stringValue
    }
    
}
