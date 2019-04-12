//
//  FBTableViewCell.swift
//  Facebook
//
//  Created by Seoyoung on 12/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class FBTableViewCell: UITableViewCell {
    static let identifier = "Cell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
