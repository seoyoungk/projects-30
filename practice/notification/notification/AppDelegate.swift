//
//  AppDelegate.swift
//  notification
//
//  Created by Seoyoung on 15/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 10.0, *){
            //경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 사용자 동의 여부 창을 실행
            let notiCenter = UNUserNotificationCenter.current()
            notiCenter.requestAuthorization(options: [.alert, .badge, .sound]){(didAllow, e) in}
            notiCenter.delegate = self
        } else {
            // 경고창, 배지, 사운드를 사용하는 알림 환경 정보를 생성하고, 이를 애플리케이션에 저장
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(setting)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        if #available(iOS 10.0, *){
            //알림 동의 여부를 확인
            UNUserNotificationCenter.current().getNotificationSettings{ settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized{
                    let nContent = UNMutableNotificationContent()
                    nContent.badge = 1
                    nContent.title = "로컬 알림 메시지"
                    nContent.subtitle = "앱이 업데이트되었습니다."
                    nContent.body = "김서영님, 앱을 열어 업데이트 내역을 확인해주세요."
                    nContent.sound = UNNotificationSound.default
                    nContent.userInfo = ["name": "김서영"]
                    
                    //알림 발송 조건 객체
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                    
                    //알림 요청 객체
                    let request = UNNotificationRequest(identifier: "wakeup", content: nContent, trigger: trigger)
                    
                    //노티피케이션 센터에 추가
                    UNUserNotificationCenter.current().add(request)
                } else {
                    print("사용자가 알림 수신을 동의하지 않았습니다.")
                }
            }
        } else {            // UILocalNotification 객체를 이용한 로컬 알림(iOS 9이하)
            // 알림 설정 확인
            let setting =  application.currentUserNotificationSettings
            
            // 알림이 설정되어 있지 않다면 로컬 알림을 보내도 받을 수 없으므로 종료함
            guard setting?.types != .none else {
                print("Can't Schedule")
                return
            }
            // 로컬 알람 인스턴스 생성
            let noti = UILocalNotification()
            noti.fireDate = Date(timeIntervalSinceNow: 10) //10초 후 발송
            noti.timeZone = TimeZone.autoupdatingCurrent //현재 위치에 따라 타임존 설정
            noti.alertBody = "앱에 재접속 하세요." //표시될 메시지
            noti.alertAction = "앱이 업데이트 되었습니다." //잠금 상태일 때 표시될 액션
            noti.applicationIconBadgeNumber = 1 //앱 아이콘 모서리에 표시될 배지
            noti.soundName = UILocalNotificationDefaultSoundName //로컬 알람 도착시 사운드
            noti.userInfo = ["name": "홍길동"] // 알람 실행 시 함께 전달하고 싶은 값. 화면에는 표시되지 않음
            
            //생성된 알람 객체를 스케쥴러에 등록
            application.scheduleLocalNotification(noti)
            
        }
    }
    
    // 활성화/비활성화 로직 처리
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        print((notification.userInfo?["name"])!)
        if application.applicationState == UIApplication.State.active{
            // 앱이 활성화 된 상태일 때
        }else if application.applicationState == .inactive{
            // 앱이 비활성화 된 상태일 때
        }
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

@available(iOS 10.0, *)
func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void){
    if notification.request.identifier == "wakeup"{
        let userInfo = notification.request.content.userInfo
        print(userInfo["name"]!)
    }
    // 알림 배너 띄워주기
    completionHandler([.alert, .badge, .sound])
}
