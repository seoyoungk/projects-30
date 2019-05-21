//
//  SolFormatter.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

struct SolFormatter {
    let landingDate: Date
    init(landingDate: Date = Date(timeIntervalSinceNow: -31725960)){
        self.landingDate = landingDate
    }
    
    func sols(fromDate date: Date) -> Int {
        let martianDay: TimeInterval = 1477 * 60
        let seconds = date.timeIntervalSince(landingDate)
        return lround(seconds / martianDay)
    }
}
