//
//  FetchPostsRequest..swift.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 28.07.2023.
//

import Foundation
import Moya

public struct FetchPostsRequest: MoyaTargetType {
    typealias Response = PostsModelData

    public var method: Moya.Method = .get
    public var path: String = ""
    var parameters: [String: Any] = [:]

    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: URLEncoding.queryString)
    }

    init(carID: Int) {
        path = "v1/car/\(carID)/posts"
    }
}
