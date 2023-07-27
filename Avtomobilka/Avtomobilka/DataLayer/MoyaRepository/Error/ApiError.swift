//
//  ApiError.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation

public final class ApiError: Decodable, Error, CustomStringConvertible {
    var field: ErrorField = .unknown
    var message: ErrorMessageByIdentifire = .unknown
    var errorDescription: String = "unknown"

    enum CodingKeys: CodingKey {
        case field
        case message
        case errorDescription
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.field = try container.decode(ErrorField.self, forKey: .field)
        self.message = try container.decode(ErrorMessageByIdentifire.self, forKey: .message)
        self.errorDescription = try container.decode(String.self, forKey: .errorDescription)
    }

    public var description: String {
        return errorDescription
    }
}
