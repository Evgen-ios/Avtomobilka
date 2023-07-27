//
//  AuthorModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

struct AuthorModel: Codable, Equatable {
    var id: Int
    var username: String
    var avatar: AvatarModel
    
    init(id: Int, username: String, avatar: AvatarModel) {
        self.id = id
        self.username = username
        self.avatar = avatar
    }
}

extension AuthorModel {
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case avatar
    }
}
