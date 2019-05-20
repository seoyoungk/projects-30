//
//  AppDelegate.swift
//  Notification_new
//
//  Created by Seoyoung on 20/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고 사용자 동의 여부 창을 실행
            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { accepted, error in
                if !accepted {
                    print("Notification access denied.")
                }
            }
        let action = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: [])
        let category = UNNotificationCategory(identifier: "normal", actions: [action], intentIdentifiers: [], options: [])
        
        UNUserNotificationCenter.current().setNotificationCategories([category])
        UNUserNotificationCenter.current().delegate = self
        return true
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.actionIdentifier == "remindLater" {
            print("remind Later")
            let newDate = Date(timeInterval: 60, since: Date())
            showNotification(date: newDate)
        }
    }
    
    func showNotification(date: Date) {
        let content = UNMutableNotificationContent()
        content.title = "Coding Reminder"
        content.body = "Ready to code? Let us do some Swift!"
        content.sound = UNNotificationSound.default
        content.categoryIdentifier = "normal"
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 300, repeats: false)
        
        let triggerDaily = Calendar.current.dateComponents([.month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDaily, repeats: true)
        let request = UNNotificationRequest(identifier: "textNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
        }
    }
    
}
