//
//  ArtistTableViewCell.swift
//  Artistry
//
//  Created by Seoyoung on 20/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ArtistTableViewCell: UITableViewCell {
    @IBOutlet weak var artistImageView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
