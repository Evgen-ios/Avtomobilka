//
//  FetchCarsRequest.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation
import Moya

public struct FetchCarsRequest: MoyaTargetType {
    typealias Response = [CarModelData]

    public var method: Moya.Method = .get
    public var path: String = "v1/cars/list"
    var parameters: [String: Any] = [:]

    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: URLEncoding.queryString)
    }

    init(page: Int) {
        parameters = [
            "page": page
        ]
    }
}
