//
//  Ablum.swift
//  MusicAlbum
//
//  Created by Seoyoung on 25/04/2019.
//  Copyright © 2019 Seoyoung. All rights reserved.
//

import UIKit

struct Album: Codable {
    var title: String
    var artist: String
    var genre: String
    var coverUrl: String
    var year: String
}

extension Album: CustomStringConvertible {
    var description: String {
        return "title: \(title)" + "artist: \(artist)" + "genre: \(genre)" + "coverUrlL: \(coverUrl)" + "year: \(year)"
    }
}

typealias AlbumData = (title: String, value: String)

extension Album {
    var tableRepresentation: [AlbumData] {
        return [ ("Artist", artist), ("Album", title), ("Genre", genre), ("Year", year)]
    }
}

