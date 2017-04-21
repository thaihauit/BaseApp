//
//  ImageRestApi.swift
//  gear
//
//  Created by Anh Nguyen on 3/17/16.
//  Copyright © 2016 BuzzElement. All rights reserved.
//

import Foundation
import BoltsSwift

class ImageRestApi : BaseRestApi {

    static let sharedInstance = ImageRestApi()
    
    func getPreSignedURL(fileType: String) -> BoltsSwift.Task<Any> {
        return callInBackgroundWithRequest(createGETRequest(apiSuffix: "images/presigned_url", params: [
            "extension": fileType as AnyObject
            ]))
    }

}
