//
//  CollectionViewController.swift
//  Pinterest
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit
import AVFoundation

class CollectionViewController: UICollectionViewController {

    var photos = Photo.allPhotos()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let layout = collectionView.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "Pattern"))
        
        collectionView!.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        if #available(iOS 11.0, *) {
            collectionView?.contentInsetAdjustmentBehavior = .always
        }
    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.photo = photos[indexPath.item]
        return cell
    }

}

extension CollectionViewController : PinterestLayoutDelegate {
    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath: IndexPath,
                        withWidth width: CGFloat) -> CGFloat {
        let photo = photos[indexPath.item]
        let boundingRect =  CGRect(x: 0, y: 0, width: width, height: CGFloat(MAXFLOAT))
        let rect  = AVMakeRect(aspectRatio: photo.image.size, insideRect: boundingRect)
        return rect.size.height
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let annotationPadding = CGFloat(4)
        let annotationHeaderHeight = CGFloat(17)
        let photo = photos[indexPath.item]
        let font = UIFont(name: "Helvetica Neue", size: 10)!
        let commentHeight = photo.heightForComment(font, width: width)
        let height = annotationPadding + annotationHeaderHeight + commentHeight + annotationPadding
        return height
    }
}
