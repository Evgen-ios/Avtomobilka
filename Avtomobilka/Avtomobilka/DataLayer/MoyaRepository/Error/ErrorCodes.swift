//
//  ErrorCodes.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation
import Moya

public enum ErrorMessageByIdentifire: String, Codable {
    case unknown
    case validationException = "VALIDATION_EXCEPTION"
    case smsNotSend = "SMS_NOT_SEND"
    case smsCodeCoolDown = "SMS_CODE_COOL_DOWN"
    case authorizationException = "AUTHORIZATION_EXCEPTION"
    case wrongCredentials = "WRONG_CREDENTIALS"
    case userNotVerified = "USER_NOT_VERIFIED"
    case userWasBlocked = "USER_WAS_BLOCKED"
    case userAlredyExists = "USER_ALREADY_EXISTS"
    case emailHasNotChanged = "EMAIL_HAS_NOT_CHANGED"
    case wrongPassword = "WRONG_PASSWORD"
    case userNotFound = "USER_NOT_FOUND"
}

public enum ErrorField: String, Codable {
    case username
    case unknown
}

public enum ErrorMessageByCode: Int, Codable {
    case sucsess = 200
    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case unprocessableEntity = 422
    case tooManyRequests  = 429
    case serverIsNotAvailable = 504
    case timeoutLimit = -1001
    case unknown
}

extension Response {
    var state: ErrorMessageByCode {
        switch self.statusCode {
        case 200...299:
            return .sucsess
        case 400:
            return .badRequest
        case 401:
            return .unauthorized
        case 404:
            return .notFound
        case 422:
            return .unprocessableEntity
        case 429:
            return .tooManyRequests
        case 500...599:
            return .serverIsNotAvailable
        case -1001:
            return .timeoutLimit
        default:
            return .unknown
        }
    }
    
    var error: ApiError? {
        let model = try? JSONDecoder().decode([ApiError].self, from: self.data)
        return model?.first
    }
}
