//
//  ShazamMediaModel.swift
//  Shazam
//
//  Created by Sarah Haddix on 4/14/24.
//

import Foundation

struct ShazamMedia: Decodable {
    let title: String?
    let subtitle: String?
    let artistName: String?
    let albumArtURL: URL?
    let genres: [String]
}

extension ShazamMedia {
    static var example: ShazamMedia {
        ShazamMedia(title: "Example", subtitle: "Example", artistName: "Example", albumArtURL: <#T##URL?#>, genres: ["pop", "rock"])
    }
}
