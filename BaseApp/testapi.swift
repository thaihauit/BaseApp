//
//  testapi.swift
//  BaseApp
//
//  Created by nguyen ha on 4/24/17.
//  Copyright © 2017 D.ace. All rights reserved.
//

import Foundation
import BoltsSwift

class testapi : BaseRestApi {
    static let sharedInstance = testapi()
    
    func testURL() -> BoltsSwift.Task<Any> {
        return callInBackgroundWithRequest(createPOSTRequest(apiSuffix: "http://dbservice.phanmemvang.com.vn:8985/GoldRetailMobile.svc/shop/list"), parser: testParser.sharedInstance)
    }
}
