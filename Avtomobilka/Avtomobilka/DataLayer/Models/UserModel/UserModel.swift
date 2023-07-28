//
//  UserModel.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

struct UserModel: Codable, Equatable {
    var id: Int
    var username: String
    var email: String?
    var about: String?
    var avatar: AvatarModel
    
    init(id: Int, username: String, email: String? = nil, about: String? = nil, avatar: AvatarModel) {
        self.id = id
        self.username = username
        self.email = email
        self.about = about
        self.avatar = avatar
    }
}

extension UserModel {
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case about
        case avatar
    }
}
