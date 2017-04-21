//
//  ApiRequest.swift
//  Grabit
//
//  Created by yo on 12/11/14.
//  Copyright (c) 2014 BuzzElement. All rights reserved.
//

import Alamofire
import Foundation

class ApiRequest: URLRequestConvertible {

    let method:String
    let path:String
    let params:[String: Any]?

    init(method: String, path: String) {
        self.method = method
        self.path   = path
        self.params = nil
    }

    init(method: String, path: String, params: [String: Any]?) {
        self.method = method
        self.path   = path
        self.params = params
    }

    var url: String {
        if path.hasPrefix("http") {
            return path
        }
        return AppConfig.sharedInstance.apiSchema + "://" + AppConfig.sharedInstance.apiDomain + path
    }
    
    /// Returns a URL request or throws if an `Error` was encountered.
    ///
    /// - throws: An `Error` if the underlying `URLRequest` is `nil`.
    ///
    /// - returns: A URL request.
    public func asURLRequest() throws -> URLRequest {
        let url = URL(string: self.url)!
        var request = URLRequest(url: url)
        request.httpMethod = method
        _ = request.allHTTPHeaderFields?.updateValue(TimeZone.autoupdatingCurrent.identifier, forKey: "Time-Zone")
        if let language = Bundle.main.preferredLocalizations.first {
            _ = request.allHTTPHeaderFields?.updateValue(language[0...1], forKey: "Accept-Language")
        }
//        if let apiToken = UserUseCase.getCurrentUser()?.api_token {
//            _ = request.allHTTPHeaderFields?.updateValue(apiToken, forKey: "Api-Token")
//        }
        return try Alamofire.URLEncoding().encode(request, with: params)
    }
    
}
