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
    
    init(id: Int, username: String, email: String? = nil, about: String? = nil) {
        self.id = id
        self.username = username
        self.email = email
        self.about = about
    }
}

extension UserModel {
    private enum CodingKeys: String, CodingKey {
        case id
        case username
        case email
        case about
    }
}
