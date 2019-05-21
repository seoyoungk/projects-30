//
//  Theme.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//


import UIKit


extension UIColor {
    public convenience init(hex6: UInt32, alpha: CGFloat = 1) {
        let divisor = CGFloat(255)
        let red     = CGFloat((hex6 & 0xFF0000) >> 16) / divisor
        let green   = CGFloat((hex6 & 0x00FF00) >>  8) / divisor
        let blue    = CGFloat(hex6 & 0x0000FF) / divisor
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
let CommonInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)


func AppFont(size: CGFloat = 18) -> UIFont {
    return UIFont(name: "OCRAStd", size: size)!
}
