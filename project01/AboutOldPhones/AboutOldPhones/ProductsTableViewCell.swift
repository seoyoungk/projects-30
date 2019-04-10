//
//  ProductsTableViewCell.swift
//  AboutOldPhones
//
//  Created by Seoyoung on 09/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ProductsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        imgView.layer.cornerRadius = 50.0
        imgView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    

}
