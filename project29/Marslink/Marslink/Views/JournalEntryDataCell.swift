//
//  JournalEntryDataCell.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class JournalEntryDateCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.font = AppFont(size: 14)
        label.textColor = UIColor(hex6: 0x42c84b)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor(hex6: 0x0c1f3f)
        contentView.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = CommonInsets
        label.frame = bounds.inset(by: UIEdgeInsets(top: 0, left: padding.left, bottom: 0, right: padding.right))
    }
}
