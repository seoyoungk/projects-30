//
//  ViewController.swift
//  message_notification
//
//  Created by Seoyoung on 15/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var msg: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func save(_ sender: Any) {
        if #available(iOS 10.0, *){
            //UserNotification 프레임워크 사용
            //알림 동의 여부 확인
            UNUserNotificationCenter.current().getNotificationSettings{ settings in
                if settings.authorizationStatus == UNAuthorizationStatus.authorized {
                    //알림 설정
                    DispatchQueue.main.async {
                        let nContent = UNMutableNotificationContent()
                        nContent.body = (self.msg.text)!
                        nContent.title = "미리알림"
                        nContent.sound = UNNotificationSound.default
                        
                        //발송 시각을 '지금으로부터 *초 형식' 으로 변환
                        let time = self.datePicker.date.timeIntervalSinceNow
                        //발송 조건 정의
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: false)
                        //발송 요청 객체 정의
                        let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
                        
                        //노티피케이션에 추가
                        UNUserNotificationCenter.current().add(request) { (_) in
                            DispatchQueue.main.async {
                                // 발송완료 안내 메시지 창
                                let date = self.datePicker.date.addingTimeInterval(9*60*60) // GMT 기준 + 9시간 = 우리나라 시간
                                let message = "알림이 등록되었습니다. 등록된 알람은 \(date)에 발송됩니다"
                                
                                let alert = UIAlertController(title: "알림 등록", message: message, preferredStyle: .alert)
                                let ok = UIAlertAction(title: "확인", style: .default)
                                alert.addAction(ok)
                                self.present(alert, animated: false)
                                
                            }
                        }
                    }
                }else {
                    let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되어 있지 않습니다", preferredStyle: .alert)
                    let ok = UIAlertAction(title: "확인", style: .default)
                    alert.addAction(ok)
                    
                    self.present(alert, animated: false)
                    return
                }
            }
            
        }else{
            //LocalNotification 객체 사용
            
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
}

