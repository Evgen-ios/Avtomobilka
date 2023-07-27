//
//  FetchDetailCarRequest.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation
import Moya

public struct FetchDetailCarRequest: MoyaTargetType {
    typealias Response = DetailCarModelData

    public var method: Moya.Method = .get
    public var path: String = ""
    var parameters: [String: Any] = [:]

    public var task: Task {
        return .requestParameters(parameters: self.parameters, encoding: URLEncoding.queryString)
    }

    init(carID: Int) {
        path = "v1/car/\(carID)"
    }
}
