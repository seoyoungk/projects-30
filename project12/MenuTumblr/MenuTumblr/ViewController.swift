//
//  ViewController.swift
//  MenuTumblr
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let transitionManager = TransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.toolbar.clipsToBounds = true
        
    }
    @IBAction func dismissButton(_ sender: UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    

}

