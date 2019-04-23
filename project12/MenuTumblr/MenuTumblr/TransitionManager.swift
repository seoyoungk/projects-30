//
//  TransitionManager.swift
//  MenuTumblr
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class TransitionManager: NSObject {
    fileprivate var presenting = false
}

extension TransitionManager: UIViewControllerAnimatedTransitioning {
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        
        let screens : (from:UIViewController, to:UIViewController) = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!, transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!)
        
        
        let menuViewController = !self.presenting ? screens.from as! MenuViewController : screens.to as! MenuViewController
        let bottomViewController = !self.presenting ? screens.to as UIViewController : screens.from as UIViewController
        
        let menuView = menuViewController.view
        let bottomView = bottomViewController.view
        
        // prepare the menu
        if (self.presenting){
            // prepare menu to fade in
            offStageMenuController(menuViewController)
        }
        
        // add the both views to our view controller
        container.addSubview(bottomView!)
        container.addSubview(menuView!)
        
        let duration = self.transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: [], animations: {
            
            if (self.presenting){
                self.onStageMenuController(menuViewController) // onstage items: slide in
            }
            else {
                self.offStageMenuController(menuViewController) // offstage items: slide out
            }
            
        }, completion: { finished in
            transitionContext.completeTransition(true)
            UIApplication.shared.keyWindow?.addSubview(screens.to.view)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func offStage(_ amount: CGFloat) -> CGAffineTransform {
        return CGAffineTransform(translationX: amount, y: 0)
    }
    
    func offStageMenuController(_ menuViewController: MenuViewController){
        
        menuViewController.view.alpha = 0
        
        // setup paramaters for 2D transitions for animations
        let topRowOffset  :CGFloat = 300
        let middleRowOffset :CGFloat = 150
        let bottomRowOffset  :CGFloat = 50
        
        menuViewController.textIcon.transform = self.offStage(-topRowOffset)
        menuViewController.textLabel.transform = self.offStage(-topRowOffset)
        
        menuViewController.quoteIcon.transform = self.offStage(-middleRowOffset)
        menuViewController.quoteLabel.transform = self.offStage(-middleRowOffset)
        
        menuViewController.chatIcon.transform = self.offStage(-bottomRowOffset)
        menuViewController.chatLabel.transform = self.offStage(-bottomRowOffset)
        
        menuViewController.photoIcon.transform = self.offStage(topRowOffset)
        menuViewController.photoLabel.transform = self.offStage(topRowOffset)
        
        menuViewController.linkIcon.transform = self.offStage(middleRowOffset)
        menuViewController.linkLabel.transform = self.offStage(middleRowOffset)
        
        menuViewController.audioIcon.transform = self.offStage(bottomRowOffset)
        menuViewController.audioLabel.transform = self.offStage(bottomRowOffset)
        
    }
    
    func onStageMenuController(_ menuViewController: MenuViewController){
        
        // prepare menu to fade in
        menuViewController.view.alpha = 1
        
        menuViewController.textIcon.transform = CGAffineTransform.identity
        menuViewController.textLabel.transform = CGAffineTransform.identity
        
        menuViewController.quoteIcon.transform = CGAffineTransform.identity
        menuViewController.quoteLabel.transform = CGAffineTransform.identity
        
        menuViewController.chatIcon.transform = CGAffineTransform.identity
        menuViewController.chatLabel.transform = CGAffineTransform.identity
        
        menuViewController.photoIcon.transform = CGAffineTransform.identity
        menuViewController.photoLabel.transform = CGAffineTransform.identity
        
        menuViewController.linkIcon.transform = CGAffineTransform.identity
        menuViewController.linkLabel.transform = CGAffineTransform.identity
        
        menuViewController.audioIcon.transform = CGAffineTransform.identity
        menuViewController.audioLabel.transform = CGAffineTransform.identity
    }
    
}

extension TransitionManager: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
}

