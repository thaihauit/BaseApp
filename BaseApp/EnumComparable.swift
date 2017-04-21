//
//  EnumComparable.swift
//  gear
//
//  Created by Alton on 12/12/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation

protocol EnumComparable {
    func order() -> Int
}

extension EnumComparable {
    
    func after(status: Self) -> Bool {
        return self.order() > status.order()
    }
    
    func before(status: Self) -> Bool {
        return self.order() < status.order()
    }
    
    func equalOrAfter(status: Self) -> Bool {
        return self.order() >= status.order()
    }
    
    func equalOrBefore(status: Self) -> Bool {
        return self.order() <= status.order()
    }
    
}
