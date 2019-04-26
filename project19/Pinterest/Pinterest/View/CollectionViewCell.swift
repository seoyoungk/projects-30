//
//  CollectionViewCell.swift
//  Pinterest
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
//    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
    
    override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
        super.apply(layoutAttributes)
        
    }
}
