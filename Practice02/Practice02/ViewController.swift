//
//  ViewController.swift
//  Practice02
//
//  Created by Seoyoung on 15/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func alert(_ sender: Any) {
        let alert = UIAlertController(title: "iTunes Store에 로그인", message: "사용자의 Apple ID vvwvv9@naver.com의 암호를 입력하십시오", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        let ok = UIAlertAction(title: "확인", style: .default){(_) in
            if let tf = alert.textFields?[0] {
                print("입력된 값은 \(tf.text!)입니다.")
            } else {
                print("입력된 값이 없습니다.")
            }
        }
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(tf) in
            tf.placeholder = "암호"
            tf.isSecureTextEntry = true
        })
        self.present(alert, animated: false)
        
    }
    
}

