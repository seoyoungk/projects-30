//
//  RoundedView.swift
//  Pinterest
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedView: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
  

}
