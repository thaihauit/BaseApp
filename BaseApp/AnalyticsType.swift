//
//  AnalyticsType.swift
//  gear
//
//  Created by Alton on 1/13/17.
//  Copyright © 2017 Symphony Creative Solutions. All rights reserved.
//

import Foundation

enum AnalyticsType: String {
    case none = "none"
    case internetConnectionIssue = "InternetConnectionIssue"
    case mostViewedScreenInAssignment = "MostViewedScreenInAssignment"
    case timeOfAppSession = "TimeOfAppSession"
    
    var key: String {
        return self.rawValue
    }
    
    var display: String {
        switch self {
        case .none:
            return "None"
        case .internetConnectionIssue:
            return "Internet connection lost"
        case .mostViewedScreenInAssignment:
            return "Most used screen"
        case .timeOfAppSession:
            return "App using time per session"
        }
    }
 
    static func get(_ key: String) -> AnalyticsType {
        if let status = AnalyticsType(rawValue: key) {
            return status
        }
        return AnalyticsType.none
    }
    
}
