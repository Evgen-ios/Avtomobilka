//
//  CarDetailsAssembly.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import Foundation
import DITranquillity

final class CarDetailsPart: DIPart {
    static func load(container: DIContainer) {
        container.register(CarDetailsViewModel.init)
            .as(CarDetailsViewModel.self)
            .lifetime(.objectGraph)
        
        container.register {
            CarDetailsViewController.loadFromNib()
            }
            .as(CarDetailsViewController.self)
            .injection({ $0.viewModel = $1 })
            .lifetime(.objectGraph)
    }
}

final class CarDetailsAssembly {
    class func createModule(_ container: DIContainer) -> CarDetailsViewController {
        return container.resolve()
    }
}
