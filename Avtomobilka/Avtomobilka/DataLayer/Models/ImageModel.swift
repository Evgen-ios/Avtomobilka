//
//  ImageModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import UIKit

struct ImageModel: Codable, Equatable {
    var id: Int
    var isPrimary: Bool
    var size: Int
    var index: Int
    var url: String
    var thumbnailUrl: String
    var image500: String
    var image100: String
    
    init(id: Int, isPrimary: Bool, size: Int, index: Int, url: String, thumbnailUrl: String, image500: String, image100: String) {
        self.id = id
        self.isPrimary = isPrimary
        self.size = size
        self.index = index
        self.url = url
        self.thumbnailUrl = thumbnailUrl
        self.image500 = image500
        self.image100 = image100
    }
}

extension ImageModel {
    private enum CodingKeys: String, CodingKey {
    case id
    case isPrimary = "is_primary"
    case size
    case index
    case url
    case thumbnailUrl = "thumbnail_url"
    case image500
    case image100
    }
}
