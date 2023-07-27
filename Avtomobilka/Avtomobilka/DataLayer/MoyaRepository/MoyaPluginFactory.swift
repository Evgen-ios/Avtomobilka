//
//  MoyaPluginFactoryPart.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import Foundation
import Moya
import DITranquillity

final class MoyaPluginFactoryPart: DIPart {
    static func load(container: DIContainer) {
        container.register(MoyaPluginFactoryImpl.init)
            .as(MoyaPluginFactory.self)
            .lifetime(.single)
    }
}

protocol MoyaPluginFactory {
    func plugins(verbose: Bool, cURL: Bool) -> [PluginType]
    func pluginsForAuth(verbose: Bool, cURL: Bool) -> [PluginType]
}

final class MoyaPluginFactoryImpl: MoyaPluginFactory {
    
    func plugins(verbose: Bool, cURL: Bool) -> [PluginType] {
        return [
            NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .formatRequestAscURL))
        ]
    }
    
    func pluginsForAuth(verbose: Bool, cURL: Bool) -> [PluginType] {
        return [NetworkLoggerPlugin(configuration: NetworkLoggerPlugin.Configuration(logOptions: .formatRequestAscURL))]
    }
}
