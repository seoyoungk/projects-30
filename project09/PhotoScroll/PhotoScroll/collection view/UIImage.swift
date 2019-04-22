//
//  UIImage.swift
//  PhotoScroll
//
//  Created by Seoyoung on 22/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

extension UIImage {
    func thumbnail10fSize(_ size: CGFloat) -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: size, height: size))
        let rect = CGRect(x: 0.0, y: 0.0, width: size, height: size)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let thumbnail = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return thumbnail!
    }
}
