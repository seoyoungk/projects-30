//
//  ContactBirthdayCell.swift
//  BirthDay
//
//  Created by Seoyoung on 29/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class ContactBirthdayCell: UITableViewCell {
    
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var birthday: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.layer.cornerRadius = 25.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
