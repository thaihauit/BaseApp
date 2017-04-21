//
//  Parsable.swift
//  gear
//
//  Created by Alton on 10/10/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import BoltsSwift

protocol Parsable {
    
    func parseInBackground(_ data: Dictionary<String, AnyObject>, apiResponse: ApiResponse?) -> BoltsSwift.Task<Any>
    func parseArrayInBackground(_ dataArray: [Dictionary<String, AnyObject>], apiResponse: ApiResponse?) -> BoltsSwift.Task<Any>
    
}
