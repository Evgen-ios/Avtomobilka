//
//  MultiMoyaProvider.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import Moya
import UIKit
import DITranquillity
import Combine
import CombineMoya
import MintLogger

class RequestProvider<T> {
    func request(_ token: T) -> AnyPublisher<Response, MoyaError> {
        fatalError("Abstract class is used as a protocol with generic. This method should be overriden.")
    }
}

extension DIContainer {
    func registerMoyaProvider(verbose: Bool, cURL: Bool) {
        register { (factory: MoyaPluginFactory) in
            MultiMoyaProvider.init(plugins: factory.pluginsForAuth(verbose: verbose, cURL: cURL))
        }
        .as(RequestProvider<MultiTarget>.self)
        .lifetime(.single)
    }
}

final class MultiMoyaProvider: RequestProvider<MultiTarget> {
    
    private let provider: MoyaProvider<MultiTarget>
    
    init(endpointClosure: @escaping MoyaProvider<MultiTarget>.EndpointClosure = MoyaProvider.defaultEndpointMapping,
         requestClosure: @escaping MoyaProvider<MultiTarget>.RequestClosure = MoyaProvider<MultiTarget>.defaultRequestMapping,
         stubClosure: @escaping MoyaProvider<MultiTarget>.StubClosure = MoyaProvider.neverStub,
         callbackQueue: DispatchQueue? = .main,
         session: Session = MoyaProvider<MultiTarget>.loggedByPulseSession(),
         plugins: [PluginType] = [],
         trackInflights: Bool = true
    ) {
        provider = MoyaProvider<MultiTarget>(endpointClosure: endpointClosure,
                                             requestClosure: requestClosure,
                                             stubClosure: stubClosure,
                                             session: session,
                                             plugins: plugins,
                                             trackInflights: trackInflights)
    }
    
    func request<T: DecodableTargetType>(_ request: T,
                                         decodingType: DecodableType = .data,
                                         secondTry: Bool = false) -> AnyPublisher<T.Response, AppError> {
        let target = MultiTarget(request)
        return provider.requestPublisher(target)
            .filterSuccess(secondTry: secondTry)
            .map(T.Response.self, decodingType: decodingType)
    }
}

protocol DecodableTargetType: Moya.TargetType {
    associatedtype Response: Decodable
}


extension AnyPublisher: Loggable where Output == Response, Failure == MoyaError {
    
    //checking error
    func filterSuccess(secondTry: Bool = false) -> AnyPublisher<Response, AppError> {
        return self
        
        //by Moya Error
            .mapError { AppError.moyaError(error: $0) }
            .flatMap { parsingErrors(with: $0,
                                     secondTry: secondTry).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
    
    fileprivate func parsingErrors(with response: Response, secondTry: Bool) -> AnyPublisher<Response, AppError> {
        
        //by status
        switch response.state {
        case .sucsess:
            return .just(response)
        default:
            break
        }
        
        //by api errors
        if let error = response.error {
            return .fail(with: AppError.apisError(item: error))
        }
        
        return .fail(with: AppError.responseError(code: response.statusCode))
    }
}

