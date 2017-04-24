//
//  testParser.swift
//  BaseApp
//
//  Created by nguyen ha on 4/24/17.
//  Copyright © 2017 D.ace. All rights reserved.
//

import Foundation
class testParser: BaseResponseObjectParser<test> {
    static let sharedInstance = testParser()
    
    override func parseObject(_ objData: Dictionary<String, AnyObject>) -> test {
        let obj = test()
        obj.ErrorCode  = objData["ErrorCode"] as! String
        obj.Result = objData["Result"] as! String
        return obj
    }
}
