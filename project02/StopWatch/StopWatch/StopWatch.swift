//
//  StopWatch.swift
//  StopWatch
//
//  Created by Seoyoung on 10/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

class StopWatch: NSObject {
    var timer: Timer
    var count: Double
    
    override init() {
        timer = Timer()
        count = 0.0
    }
}
