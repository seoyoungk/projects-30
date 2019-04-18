//
//  FBUser.swift
//  Facebook
//
//  Created by Seoyoung on 12/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

class FBUser {
    var name: String
    var nickName: String
    var education: String 
    
    init(name: String, nickName: String = "seoyoung", education: String){
    self.name = name
    self.nickName = nickName
    self.education = education
    }
}
