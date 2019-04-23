//
//  ViewController.swift
//  Interests
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    fileprivate var interests = Interest.createInterests()
//    fileprivate struct Storyboard {
//        static let cellIdentifier = "Interest Cell"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Interest Cell", for: indexPath) as! InterestCollectionViewCell
        cell.interest = interests[indexPath.item]
        return cell
    }
    
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthWithSpace = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        
        let index = (offset.x + scrollView.contentInset.left) / cellWidthWithSpace
        let roundIndex = round(index)
        
        offset = CGPoint(x: roundIndex * cellWidthWithSpace - scrollView.contentInset.left, y: -scrollView.contentInset.top)
    }
}
