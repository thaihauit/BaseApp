//
//  ApiResponse.swift
//  gear
//
//  Created by Elaine Chong on 11/11/15.
//  Copyright © 2015 BuzzElement. All rights reserved.
//

class ApiResponse {
    var result: Any?
    var headers: [AnyHashable: Any]
    var statusCode: Int = -1
    var message = ""
    var point: Int = 0
    var modelData: Any?
    
    init(result: Any?, headers: [AnyHashable: Any], statusCode: Int, message: String, point: Int) {
        self.result = result
        self.headers = headers
        self.statusCode = statusCode
        self.message = message
        self.point = point
    }
    
    init(result: Any?, headers: [AnyHashable: Any], statusCode: Int) {
        self.result = result
        self.headers = headers
        self.statusCode = statusCode
    }
    
}
