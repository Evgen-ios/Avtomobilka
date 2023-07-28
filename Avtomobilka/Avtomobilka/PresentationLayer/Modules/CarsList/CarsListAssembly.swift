//
//  CarsListAssembly.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import Foundation
import DITranquillity

final class CarsListPart: DIPart {
    static func load(container: DIContainer) {
        container.register(CarsListViewModel.init)
            .as(CarsListViewModel.self)
            .lifetime(.objectGraph)
        
        container.register {
            CarsListViewController.loadFromNib()
        }
        .as(CarsListViewController.self)
        .injection({ $0.viewModel = $1 })
        .lifetime(.objectGraph)
    }
}

final class CarsListAssembly {
    class func createModule(_ container: DIContainer) -> CarsListViewController {
        return container.resolve()
    }
}
