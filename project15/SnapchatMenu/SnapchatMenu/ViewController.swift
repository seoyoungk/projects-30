//
//  ViewController.swift
//  SnapchatMenu
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    
    enum vcName: String {
        case chat = "ChatViewController"
        case stories = "StoriesViewController"
        case discover = "DiscoverViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let chatVC = UIViewController(nibName: vcName.chat.rawValue, bundle: nil)
        let storiesVC = UIViewController(nibName: vcName.stories.rawValue, bundle: nil)
        let discoverVC = UIViewController(nibName: vcName.discover.rawValue, bundle: nil)
        
        add(childViewController: chatVC, parentViewController: self)
        add(childViewController: storiesVC, parentViewController: self)
        add(childViewController: discoverVC, parentViewController: self)
        
        let snapView = UIImageView(image: UIImage(named: "Snap"))
        changeX(ofView: snapView, xPosition: view.frame.width)
        scrollView.addSubview(snapView)
        
        changeX(ofView: storiesVC.view, xPosition: view.frame.width * 2)
        changeX(ofView: discoverVC.view, xPosition: view.frame.width * 3)

        scrollView.contentSize = CGSize(width: view.frame.width * 4, height: view.frame.height)
        scrollView.contentOffset.x = view.frame.width
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    fileprivate func changeX(ofView view: UIView, xPosition: CGFloat) {
        var frame = view.frame
        frame.origin.x = xPosition
        view.frame = frame
    }
    
    fileprivate func add(childViewController: UIViewController, parentViewController: UIViewController) {
        addChild(childViewController)
        scrollView.addSubview(childViewController.view)
        childViewController.didMove(toParent: parentViewController)
    }
}

