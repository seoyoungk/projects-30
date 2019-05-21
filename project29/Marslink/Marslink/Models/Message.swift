//
//  Message.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

class Message: NSObject, DateSortable {
    let date: Date
    let text: String
    let user: User
    
    init(date: Date, text: String, user: User) {
        self.date = date
        self.text = text
        self.user = user
    }
}
