//
//  AnalyticsInfo.swift
//  gear
//
//  Created by Alton on 1/13/17.
//  Copyright © 2017 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import RealmSwift

class AnalyticsInfo: Object {
    dynamic var id = ""
    dynamic var type_str = ""
    dynamic var task_group_id: Int = -1
    
    override class func primaryKey() -> String {
        return "id"
    }
    
    var type: AnalyticsType {
        get {
            return AnalyticsType.get(type_str)
        }
        
        set(newValue) {
            type_str = newValue.key
        }
    }
    
}
