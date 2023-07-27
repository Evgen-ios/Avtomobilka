//
//  PublicationService.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import DITranquillity
import Combine
import Moya

class PublicationServicePart: DIPart {
    static func load(container: DIContainer) {
        container.register(PublicationServiceImp.init)
            .as(PublicationService.self)
            .injection(cycle: true, { $0.moyaProvider = $1 })
            .lifetime(.single)
        container.registerMoyaProvider(verbose: true, cURL: true)
    }
}

protocol PublicationService {
    func FetchCars(page: Int) -> AnyPublisher<[CarModelData], AppError>
    func FetchDetailCar(carID: Int) -> AnyPublisher<DetailCarModelData, AppError>
}

final class PublicationServiceImp: PublicationService {
    var moyaProvider: MultiMoyaProvider!
    
    func FetchCars(page: Int) -> AnyPublisher<[CarModelData], AppError> {
        let request = FetchCarsRequest(page: page)
        return moyaProvider.request(request)
    }
    
    func FetchDetailCar(carID: Int) -> AnyPublisher<DetailCarModelData, AppError> {
        let request = FetchDetailCarRequest(carID: carID)
        return moyaProvider.request(request)
    }
    
}
