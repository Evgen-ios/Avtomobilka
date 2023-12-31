//
//  CarDetailsCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 27.07.2023.
//

import DITranquillity
import UIKit
import MintRouter

class CarDetailsCoordinator: BaseCoordinator<CarDetailsViewController> {
    
    // MARK: - Properties
    private var bag = CancelBag()
    
    // MARK: - Init
    init(_ container: DIContainer, model: CarModelData) {
        super.init(container)
        rootViewController = CarDetailsAssembly.createModule(container)
        rootViewController.viewModel.input.carID.send(model.id)
        rootViewController.title = model.name
    }
    
    // MARK: - Inherited Methods
    override func start() {
        
    }
}


