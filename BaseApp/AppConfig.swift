//
//  AppConfig.swift
//  gear
//
//  Created by Alton on 23/09/16.
//  Copyright (c) 2016 Symphony Creative Solutions. All rights reserved.
//
import Foundation

class AppConfig : NSObject {

    static let sharedInstance = AppConfig()
    
    let googleStack = true
    
    #if PROD
        let apiSchema = "https"
    #else
        let apiSchema = "http"
    #endif
    
    #if PROD
        let apiDomain = "www.gear71.cn"
        let fabricEnabled = true
        let appAnalyticsEnabled = true
        let versionSuffix = ""
    #elseif SCSTESTERSG_DEBUG
        let apiDomain = "geartestingsg.symcresol.com:8081"
        let fabricEnabled = true
        let appAnalyticsEnabled = true
        let versionSuffix = "(testingsg)"
    #elseif SCSTESTERSG_RELEASE
        let apiDomain = "geartestingsg.symcresol.com:8081"
        let fabricEnabled = true
        let appAnalyticsEnabled = true
        let versionSuffix = "(testingsg)"
    #elseif SCSTESTERCN_DEBUG
        let apiDomain = "geartestingcn.symcresol.com:8081"
        let fabricEnabled = true
        let appAnalyticsEnabled = true
        let versionSuffix = "(testingcn)"
    #elseif SCSTESTERCN_RELEASE
        let apiDomain = "geartestingcn.symcresol.com:8081"
        let fabricEnabled = true
        let appAnalyticsEnabled = true
        let versionSuffix = "(testingcn)"
    #else
        let apiDomain = ""
        let fabricEnabled = false
        let appAnalyticsEnabled = false
        let versionSuffix = "(nightly)"
    #endif
    
    var getAppVersion: String {
        if let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String {
            return version + versionSuffix
        }
        return ""
    }

}
