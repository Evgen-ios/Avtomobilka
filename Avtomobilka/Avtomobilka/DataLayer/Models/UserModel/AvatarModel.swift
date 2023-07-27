//
//  AvatarModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

struct AvatarModel: Codable, Equatable {
    var path: String
    var url: String
    
    init(path: String, url: String) {
        self.path = path
        self.url = url
    }
}

extension AvatarModel {
    private enum CodingKeys: String, CodingKey {
        case path
        case url
    }
}
