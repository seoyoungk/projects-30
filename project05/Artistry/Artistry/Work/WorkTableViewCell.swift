//
//  WorkTableViewCell.swift
//  Artistry
//
//  Created by Seoyoung on 20/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class WorkTableViewCell: UITableViewCell {
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var workTitleLabel: UILabel!
    @IBOutlet weak var moreInfoTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
