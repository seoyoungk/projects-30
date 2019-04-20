//
//  TodoItem.swift
//  TodoList
//
//  Created by Seoyoung on 19/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    var id: String
    var title: String
    var date: Date
    var image: String
    
    init(id: String, title: String, date: Date, image: String) {
        self.id = id
        self.title = title
        self.date = date
        self.image = image
    }
}
