//
//  BaseRestApi.swift
//  gear
//
//  Created by Anh Nguyen on 3/17/16.
//  Copyright © 2016 BuzzElement. All rights reserved.
//

import Foundation
import RealmSwift
import BoltsSwift

class BaseRestApi: NSObject {

    let default_version = "v1"
    let apiPrefix = "/api"
    
    func callInBackgroundWithRequest<T: Parsable>(_ apiRequest: ApiRequest, parser: T?) -> BoltsSwift.Task<Any> {
        if parser != nil {
            return callInBackgroundWithRequest(apiRequest).continueWithTask(continuation: { (task: BoltsSwift.Task<Any>) -> BoltsSwift.Task<Any> in
                if let response = task.result as? ApiResponse {
                    if let data = response.result as? Dictionary<String, AnyObject> {
                        return parser!.parseInBackground(data, apiResponse: response)
                    } else if let dataArray = response.result as? [Dictionary<String, AnyObject>] {
                        return parser!.parseArrayInBackground(dataArray, apiResponse: response)
                    }
                }
                return task
            })
        } else {
            return callInBackgroundWithRequest(apiRequest)
        }
    }
    
    func downloadDataInBackgroundWithRequest(_ apiRequest: ApiRequest, toPath path: URL) -> BoltsSwift.Task<Any> {
        return ApiClient.sharedInstance.download(apiRequest, toPath: path)
    }
    
    func callInBackgroundWithRequest(_ apiRequest: ApiRequest) -> BoltsSwift.Task<Any> {
        return ApiClient.sharedInstance.callInBackground(apiRequest)
    }

    func createGETRequest(apiSuffix: String, apiVersion: String? = nil, params: [String: Any]? = nil) -> ApiRequest {
        return createApiRequest(method: "GET", path: getPath(apiSuffix: apiSuffix, apiVersion: apiVersion), params: params)
    }
    
    func createGETRequest(path: String, params: [String: Any]? = nil) -> ApiRequest {
        return createApiRequest(method: "GET", path: path, params: params)
    }
    
    func createPOSTRequest(apiSuffix: String, apiVersion: String? = nil, params: [String: Any]? = nil) -> ApiRequest {
        return createApiRequest(method: "POST", path: getPath(apiSuffix: apiSuffix, apiVersion: apiVersion), params: params)
    }
    
    func createPUTRequest(apiSuffix: String, apiVersion: String? = nil, params: [String: Any]? = nil) -> ApiRequest {
        return createApiRequest(method: "PUT", path: getPath(apiSuffix: apiSuffix, apiVersion: apiVersion), params: params)
    }
    
    func createDELETERequest(apiSuffix: String, apiVersion: String? = nil, params: [String: Any]? = nil) -> ApiRequest {
        return createApiRequest(method: "DELETE", path: getPath(apiSuffix: apiSuffix, apiVersion: apiVersion), params: params)
    }
    
    fileprivate func createApiRequest(method: String, path: String, params: [String: Any]? = nil) -> ApiRequest {
        if params != nil {
            return ApiRequest(method: method, path: path, params: params)
        } else {
            return ApiRequest(method: method, path: path)
        }
    }
    
    func getPath(apiSuffix: String, apiVersion: String? = nil) -> String {
        if let version = apiVersion {
            return "\(apiPrefix)/\(version)/\(apiSuffix)"
        } else {
            return "\(apiPrefix)/\(default_version)/\(apiSuffix)"
        }
    }
    
}
