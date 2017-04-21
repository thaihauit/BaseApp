/**
 User.swift
 created by D.ace on 21/04/2017
 */

import Foundation
import RealmSwift

class User: Object {

    dynamic var id: Int = -1
    dynamic var name = ""
    dynamic var image_id: Int = -1
    dynamic var phone_number = ""
    dynamic var working_info: Int = -1
    dynamic var gender: Int = -2
    dynamic var date_of_birthday: Int = -1
    dynamic var image: Image?
    
    override class func primaryKey() -> String {
        return "id"
    }
    
}
