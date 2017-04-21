//
//  AppAnalyticsManager.swift
//  gear
//
//  Created by Alton Tran on 5/9/16.
//  Copyright © 2016 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import Mixpanel
import Fabric
import Crashlytics
import DateTools

@objc protocol AppAnalyticInfoInterface {
    @objc optional func getScreenName() -> String
}

class AppAnalyticsManager: NSObject {

    static let sharedInstance = AppAnalyticsManager()

    var mixPanel: Mixpanel?
    static var mixPanelApiToken = "432ef75d9a5197e8327f3a00e0513d6f"
    
    func create() {
        if AppConfig.sharedInstance.appAnalyticsEnabled {
            mixPanel = Mixpanel.sharedInstance(withToken: AppAnalyticsManager.mixPanelApiToken)
            if AppConfig.sharedInstance.fabricEnabled {
                Fabric.with([Crashlytics.self(), Answers.self()])
            }
        }
    }
    
    var isAvailableForLogging: Bool {
        return AppConfig.sharedInstance.appAnalyticsEnabled && AppConfig.sharedInstance.fabricEnabled
    }
    
    var currentTimeInSeconds: Int {
        return Int(Date().timeIntervalSince1970)
    }
    
    func getScreenSessionInfoId(screenName: String, assignmentNumber: String) -> String {
        return "\(assignmentNumber)_\(screenName)"
    }
    
    func getAppSessionInfoId(assignmentNumber: String) -> String {
        return assignmentNumber
    }
    
    func getNetworkIssueInfoId(assignmentNumber: String) -> String {
        return assignmentNumber
    }
    
    
}
