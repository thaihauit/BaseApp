//
//  ResourceProvider.swift
//  gear
//
//  Created by Alton on 9/26/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import UIKit

class ResourceProvider {

    class func getViewController<T: UIViewController>(_ classType: T.Type) -> T {
        return classType.init(nibName:String(describing: classType).components(separatedBy: ".").last!, bundle:nil)
    }
    
}
