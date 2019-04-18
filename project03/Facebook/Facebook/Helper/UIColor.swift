//
//  UIColor.swift
//  Facebook
//
//  Created by Seoyoung on 12/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

public extension UIColor {
    convenience init(r: Int, g: Int, b: Int, a: CGFloat) {
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: a)
    }
    convenience init(hex: Int){ 
        self.init(r: (hex & 0xff0000) >> 16, g: (hex & 0xff00) >> 8, b: (hex & 0xff), a: 1)
    }
}
