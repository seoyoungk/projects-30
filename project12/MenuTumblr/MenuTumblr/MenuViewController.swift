//
//  MenuViewController.swift
//  MenuTumblr
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    let transitionManager = TransitionManager()
    
    @IBOutlet weak var textIcon: UIImageView!
    @IBOutlet weak var photoIcon: UIImageView!
    @IBOutlet weak var quoteIcon: UIImageView!
    @IBOutlet weak var linkIcon: UIImageView!
    @IBOutlet weak var chatIcon: UIImageView!
    @IBOutlet weak var audioIcon: UIImageView!
    
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var audioLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.transitioningDelegate = self.transitionManager
    }
    


}
