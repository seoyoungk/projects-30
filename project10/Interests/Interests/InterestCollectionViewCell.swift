//
//  InterestCollectionViewCell.swift
//  Interests
//
//  Created by Seoyoung on 23/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class InterestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var featuredImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    fileprivate func updateUI() {
        titleLabel.text = interest.title
        featuredImageView.image = interest.featuredImage
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
}
