//
//  ApiError.swift
//  gear
//
//  Created by Elaine Chong on 11/11/15.
//  Copyright © 2015 BuzzElement. All rights reserved.
//

import Alamofire

class ApiError: NSError {
    var error: NSError
    var statusCode: Int = -1
    var message = ""

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(statusCode: Int, error: NSError, message: String = "") {
        self.statusCode = statusCode
        self.error      = error
        self.message    = message
        super.init(domain: error.domain, code: error.code, userInfo: error.userInfo)
    }

}
