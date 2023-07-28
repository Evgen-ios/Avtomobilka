//
//  AppFramework.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import Foundation

public class AppFramework: DIFramework {
    public static func load(container: DIContainer) {
        container.append(part: ServicesPart.self)
        container.append(part: PresentersPart.self)
        container.append(part: OtherPart.self)
    }
}

private class ServicesPart: DIPart {
    static let parts: [DIPart.Type] = [
        PublicationServicePart.self
    ]

    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }
    }
}

private class PresentersPart: DIPart {
    static let parts: [DIPart.Type] = [
        CarsListPart.self,
        CarDetailsPart.self
    ]

    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }
    }
}

private class OtherPart: DIPart {
    static let parts: [DIPart.Type] = [
        MoyaPluginFactoryPart.self
    ]
    
    static func load(container: DIContainer) {
        for part in self.parts {
            container.append(part: part)
        }
    }
}
