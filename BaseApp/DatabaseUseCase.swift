/**
 DatabaseUseCase.swift
 created by D.ace on 21/04/2017
 */

import Foundation
import RealmSwift

class DatabaseUseCase: NSObject {
    
    class func select<T: Object>(_ classType: T.Type) -> DatabaseQuery<T>? {
        return DatabaseSession.mainSession().queryForObjects(T.self)
    }
    
    class func getUser(whenUserID userID: Int) -> User? {
        return select(User.self)?.getById(userID)
    }
}

