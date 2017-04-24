//
//  BaseResponseParser.swift
//  gear
//
//  Created by Alton on 10/10/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import BoltsSwift

class BaseResponseObjectParser<T: Any> {
    
    func parse(_ obj: Dictionary<String, AnyObject>) -> T {
        return self.parseObject(obj)
    }
    
    func parseArray(_ arrayObj: [Dictionary<String, AnyObject>]) -> [T] {
        var objs:[T] = []
        for obj in arrayObj {
            objs.append(self.parse(obj))
        }
        return objs
    }
    
    internal func parseObject(_ objData: Dictionary<String, AnyObject>) -> T {
        preconditionFailure("This method must be overridden")
    }
    
}

extension BaseResponseObjectParser: Parsable {
    
    func parseInBackground(_ data: Dictionary<String, AnyObject>, apiResponse: ApiResponse?) -> BoltsSwift.Task<Any> {
        let task = TaskCompletionSource<Any>()
        DispatchQueue.main.async {
            let obj = self.parse(data)
            if apiResponse != nil {
                apiResponse!.modelData = obj
                task.set(result: apiResponse!)
            } else {
                task.set(result: obj)
            }
        }
        return task.task
    }
    
    func parseArrayInBackground(_ dataArray: [Dictionary<String, AnyObject>], apiResponse: ApiResponse?) -> BoltsSwift.Task<Any> {
        let task = TaskCompletionSource<Any>()
        DispatchQueue.main.async {
            let objs = self.parseArray(dataArray)
            if apiResponse != nil {
                apiResponse!.modelData = objs
                task.set(result: apiResponse!)
            } else {
                task.set(result: objs)
            }
        }
        return task.task
    }
    
}
