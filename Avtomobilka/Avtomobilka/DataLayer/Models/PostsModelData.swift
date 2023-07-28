//
//  PostsModelData.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import Foundation

struct PostsModelData: Codable, Equatable {
    var posts: [PostModelData]
    var user: UserModel
    var autoCount: Int?
    var mainAutoName: String?
    
    init(posts: [PostModelData], user: UserModel, autoCount: Int? = nil, mainAutoName: String? = nil) {
        self.posts = posts
        self.user = user
        self.autoCount = autoCount
        self.mainAutoName = mainAutoName
    }
}

extension PostsModelData {
    private enum CodingKeys: String, CodingKey {
        case posts
        case user
        case autoCount = "auto_count"
        case mainAutoName = "main_auto_name"
    }
}
