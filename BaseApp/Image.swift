//
//  Assignment.swift
//  nyk
//
//  Created by Elaine Chong on 6/22/15.
//  Copyright (c) 2015 BuzzElement. All rights reserved.
//

import Foundation
import RealmSwift

class Image: Object {

    dynamic var id: Int = -1
    dynamic var url = ""
    dynamic var thumb_512x320_url = ""
    dynamic var thumb_128x128_url = ""
    dynamic var status = ""
    dynamic var image_width: Int = 0
    dynamic var image_height: Int = 0
    dynamic var center_x: Float = 0
    dynamic var center_y: Float = 0

    override class func primaryKey() -> String {
        return "id"
    }

    var isReady: Bool {
        return self.status == "ready"
    }

}
