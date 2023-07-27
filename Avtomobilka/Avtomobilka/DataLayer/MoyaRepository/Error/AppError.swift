//
//  AppError.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Alamofire
import Foundation
import Moya

public protocol ErrorDisplayable {
    var displayMessage: String? { get }
}

public protocol ErrorCode {
    var code: Int? { get }
}

public protocol FetchApiError {
    var apiError: ApiError? { get }
}

public protocol FieldType {
    var field: ErrorField? { get }
}

public enum AppError: Error {
    case apisError(item: ApiError)
    case responseError(code: Int)
    case moyaError(error: MoyaError)
}

extension AFError: ErrorDisplayable {
    public var displayMessage: String? {
        return  "Network \(self.responseCode ?? -1)"
    }
}

extension Error {
    var code: Int {
        if let codeRequest = (self as? ErrorCode)?.code {
            return codeRequest
        }
        return 0
    }

    var message: String {
        if let text = (self as? ErrorDisplayable)?.displayMessage {
            return text
        }
        if let text = self._userInfo?[NSLocalizedDescriptionKey] as? String {
            return text
        }
        return "\(self)"
    }
    
    var field: ErrorField {
            if let fieldText = (self as? FieldType)?.field {
                return fieldText
            }
            return .unknown
        }
}
