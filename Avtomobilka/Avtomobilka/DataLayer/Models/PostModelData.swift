//
//  PostModelData.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

typealias PostsModelData = [PostModelData]

struct PostModelData: Codable, Equatable {
    var id: Int
    var text: String
    var likeCount: String
    var createdAt: String
    var commentCount: Int
    var img: String
    var author: AuthorModel
    var autoCount: Int
    var mainAutoName: String
    
    init(id: Int, text: String, like_count: String, created_at: String, comment_count: Int, img: String, author: AuthorModel, auto_count: Int, main_auto_name: String) {
        self.id = id
        self.text = text
        self.likeCount = like_count
        self.createdAt = created_at
        self.commentCount = comment_count
        self.img = img
        self.author = author
        self.autoCount = auto_count
        self.mainAutoName = main_auto_name
    }
}

extension PostModelData {
    private enum CodingKeys: String, CodingKey {
        case id
        case text
        case likeCount = "like_count"
        case createdAt = "created_at"
        case commentCount = "comment_count"
        case img
        case author
        case autoCount = "auto_count"
        case mainAutoName = "main_auto_name"
    }
}
