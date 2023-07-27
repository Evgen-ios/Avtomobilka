//
//  Mapping.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import Foundation
import Moya
import Alamofire
import Combine

enum DecodableType {
    case data
    case header
    case image
}

public class ImageTarget: Decodable {
    var image: Image?
    
    init(image: Image) {
        self.image = image
    }
    
    required public init(from decoder: Decoder) throws {}
}

public class HeadersTarget: Decodable {
    var headers: Alamofire.HTTPHeaders?
    
    init(headers: Alamofire.HTTPHeaders) {
        self.headers = headers
    }
    
    required public init(from decoder: Decoder) throws {}
}

extension AnyPublisher where Output == Response, Failure == AppError {
    func map<D: Decodable>(_ type: D.Type,
                           decodingType: DecodableType = .data) -> AnyPublisher<D, AppError> {
        
        switch decodingType {
        case .data:
            return self
                .tryMap { response in
                    try response.map(D.self, failsOnEmptyData: false)
                }
                .mapError { error in
                    if let appError = error as? AppError {
                        return appError
                    }
                    
                    if let moyaError = error as? MoyaError {
                        return AppError.moyaError(error: moyaError)
                    }
                    
                    return AppError.responseError(code: 500)
                }
                .eraseToAnyPublisher()
        case .header:
            return self
                .compactMap {$0.response!.headers}
                .map {HeadersTarget(headers: $0) as! D}
                .eraseToAnyPublisher()
        case .image:
            return self
                .tryMap { response in
                    try response.mapImage()
                }
                .map {ImageTarget(image: $0) as! D}
                .mapError {$0 as! AppError}
                .eraseToAnyPublisher()
        }
    }
}

extension Publisher where Output == Data {
    func decode<T: Decodable>(as type: T.Type = T.self, using decoder: JSONDecoder = .init()) -> Publishers.Decode<Self, T, JSONDecoder> {
        decode(type: type, decoder: decoder)
    }
}

extension Publisher {
    func convertToResult() -> AnyPublisher<Result<Output, Failure>, Never> {
        self.map(Result.success)
            .catch { Just(.failure($0)) }
            .eraseToAnyPublisher()
    }
}

extension AnyPublisher {
    static func just(_ output: Output) -> Self {
        Just(output)
            .setFailureType(to: Failure.self)
            .eraseToAnyPublisher()
    }
    
    static func fail(with error: Failure) -> Self {
        Fail(error: error).eraseToAnyPublisher()
    }
}

extension Publisher {
    func decode<Item, Coder>(type: Item.Type,
                             decoder: Coder,
                             errorTransform: @escaping (Error) -> Failure) -> Publishers.FlatMap<Publishers.MapError<Publishers.Decode<Just<Self.Output>, Item, Coder>, Self.Failure>, Self> where Item : Decodable, Coder : TopLevelDecoder, Self.Output == Coder.Input {
        return flatMap {
            Just($0)
                .decode(type: type, decoder: decoder)
                .mapError { errorTransform($0) }
        }
    }
}
