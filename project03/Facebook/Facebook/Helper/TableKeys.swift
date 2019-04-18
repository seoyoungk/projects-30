//
//  TableKeys.swift
//  Facebook
//
//  Created by Seoyoung on 12/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import Foundation

public struct TableKeys{
    static let section = "section"
    static let rows = "rows"
    static let imageName = "imageName"
    static let title = "title"
    static let subTitle = "subTitle"
    static let seeMore = "See More..."
    static let addFavorites = "Add Favorites..."
    static let logout = "Log Out"
    
    static func populate(_ user: FBUser) -> [[String: Any]] {
        return [
            [
                TableKeys.rows: [
                    [TableKeys.imageName: user.nickName, TableKeys.title: user.name, TableKeys.subTitle: "View your profile"]
                ]
            ], 
            [
                TableKeys.rows: [
                    [TableKeys.imageName: Specs.imageList.friends, TableKeys.title: "Friends"],
                    [TableKeys.imageName: Specs.imageList.events, TableKeys.title: "Events"],
                    [TableKeys.imageName: Specs.imageList.groups, TableKeys.title: "Groups"],
                    [TableKeys.imageName: Specs.imageList.education, TableKeys.title: user.education],
                    [TableKeys.imageName: Specs.imageList.townHall, TableKeys.title: "Town Hall"],
                    [TableKeys.imageName: Specs.imageList.instantGames, TableKeys.title: "Instant Games"],
                    [TableKeys.title: TableKeys.seeMore]
                ]
            ],
            [
                TableKeys.section: "FAVORITES",
                TableKeys.rows: [
                    [TableKeys.title: TableKeys.addFavorites]
                ]
            ],
            [
                TableKeys.rows: [
                    [TableKeys.imageName: Specs.imageList.settings, TableKeys.title: "Settings"],
                    [TableKeys.imageName: Specs.imageList.privacyShortcuts, TableKeys.title: "Privacy Shortcuts"],
                    [TableKeys.imageName: Specs.imageList.helpSupport, TableKeys.title: "Help and Support"]
                ]
            ],
            [
                TableKeys.rows: [
                    [TableKeys.title: TableKeys.logout]
                ]
            ]
            
        ]
    }
    
}
