//
//  NetworkUtil.swift
//  gear
//
//  Created by Alton on 2/6/17.
//  Copyright © 2017 Symphony Creative Solutions. All rights reserved.
//

import Foundation
import UIKit

class NetworkUtil {
    
    static let sharedInstance = NetworkUtil()
    
    let reachability = Reachability()!
    
    let networkConnectionOkayNotification = Notification.Name(rawValue: "NetworkConnectionOkayNotification")
    let networkConnectionProblemNotification = Notification.Name(rawValue: "NetworkConnectionProblemNotification")
    
    func isConnectionOkay() -> Bool {
        if reachability.isReachable {
            return true
        }
        return false
    }
    
    func openNetworkSettingsPage() -> Void {
        UIApplication.shared.openURL(URL(string:"prefs:root=WIFI")!)
    }
    
    func registerNetworkStatusChangedNotification(_ context: Any, onNetworkConnectionOkay: Selector?, onNetworkConnectionProblem: Selector?) {
        if onNetworkConnectionOkay != nil {
            NotificationCenter.default.addObserver(context, selector: onNetworkConnectionOkay!, name: networkConnectionOkayNotification, object: nil)
        }
        if onNetworkConnectionProblem != nil {
            NotificationCenter.default.addObserver(context, selector: onNetworkConnectionProblem!, name: networkConnectionProblemNotification, object: nil)
        }
    }
    
    func unregisterNetworkStatusChangedNotification(_ context: Any) {
        NotificationCenter.default.removeObserver(context, name: networkConnectionOkayNotification, object: nil)
        NotificationCenter.default.removeObserver(context, name: networkConnectionProblemNotification, object: nil)
    }
    
    func startNetworkStatusChangedNotification() {
        if reachability.whenReachable == nil {
            reachability.whenReachable = { reachability in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: self.networkConnectionOkayNotification, object: nil)
                }
            }
            reachability.whenUnreachable = { reachability in
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: self.networkConnectionProblemNotification, object: nil)
                }
            }
        }
        do {
            try reachability.startNotifier()
        } catch {
        }
    }
    
    func stopNetworkStatusChangedNotification() {
        reachability.stopNotifier()
    }
    
}
