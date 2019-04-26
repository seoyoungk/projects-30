//
//  HTTP.swift
//  MusicAlbum
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit


class HTTPClient {
    
    func getRequest(_ url: String) -> (AnyObject) {
        return Data() as (AnyObject)
    }
    
    func postRequest(_ url: String, body: String) -> (AnyObject){
        return Data() as (AnyObject)
    }
    
    // download image via url, use it in background
    func downloadImage(_ url: String) -> (UIImage) {
        let aURL = URL(string: url)
        
        guard let data = try? Data(contentsOf: aURL!) else {
            return UIImage()
        }
        
        let image = UIImage(data: data)
        return image!
    }
    
}
