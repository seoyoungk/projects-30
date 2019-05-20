//
//  ViewController.swift
//  Notification_new
//
//  Created by Seoyoung on 20/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var delegate = UIApplication.shared.delegate as? AppDelegate
    @IBOutlet weak var date: UIDatePicker!
    
    @IBAction func datePicker(_ sender: UIDatePicker) {
        print("date = \(date.date)")
        delegate?.showNotification(date: date.date)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
