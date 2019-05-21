//
//  NSObject+IGList.swift
//  Marslink
//
//  Created by Seoyoung on 21/05/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation
import IGListKit

// MARK: - IGListDiffable
extension NSObject: IGListDiffable {
    
    public func diffIdentifier() -> NSObjectProtocol {
        return self
    }
    
    public func isEqual(toDiffableObject object: IGListDiffable?) -> Bool {
        return isEqual(object)
    }
    
}
