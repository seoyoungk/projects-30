//
//  DecompressedImage.swift
//  Pinterest
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

extension UIImage {
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        draw(at: CGPoint.zero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage!
    }
}
