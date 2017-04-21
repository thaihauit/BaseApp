//
//  NotificationManager.swift
//  gear
//
//  Created by Alton Tran on 3/25/16.
//  Copyright © 2016 BuzzElement. All rights reserved.
//

import Foundation
import UserNotifications
import AudioToolbox
import AVFoundation
import UIKit

class NotificationManager: NSObject {

    static let sharedInstance = NotificationManager()
    
    var notificationAlertPlayer: AVAudioPlayer?
    
    func registerRemoteNotification() {
        if #available(iOS 10.0, *) {
            let authOptions : UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {(granted, error) in
                    if (granted) {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
            })
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = UIApplication.shared.delegate as? UNUserNotificationCenterDelegate
        } else {
            let notificationTypes: UIUserNotificationType = [UIUserNotificationType.alert, UIUserNotificationType.badge, UIUserNotificationType.sound]
            let notificationSettings = UIUserNotificationSettings(types: notificationTypes, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(notificationSettings)
        }
    }
    
    func scheduleLocalNotification(message: String, title: String?, userInfo: [AnyHashable: Any]? = nil) {
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            if title != nil {
                content.title = title!
            }
            content.body = message
            content.sound = UNNotificationSound.default()
            if userInfo != nil {
                content.userInfo = userInfo!
            }
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)
            let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        } else {
            let localNotification = UILocalNotification()
            localNotification.alertBody = message
            localNotification.timeZone = TimeZone.autoupdatingCurrent
            if userInfo != nil {
                localNotification.userInfo = userInfo
            }
            if #available(iOS 8.2, *) {
                localNotification.alertTitle = title
            }
            localNotification.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(localNotification)
        }
    }
}

extension NotificationManager: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        try? AVAudioSession.sharedInstance().setActive(false)
        notificationAlertPlayer = nil
    }
    
}
