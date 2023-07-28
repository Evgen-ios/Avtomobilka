//
//  CarsListCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit
import MintRouter

class CarsListCoordinator: BaseCoordinator<CarsListViewController>, BackRoute {
    
    // MARK: - Properties
    private var bag = CancelBag()
    private var window: UIWindow
    
    // MARK: - Init
    init(_ container: DIContainer, window: UIWindow) {
        self.window = window
        super.init(container)
        rootViewController = CarsListAssembly.createModule(container)
        
        rootViewController.viewModel.input.openCarDetails.publisher
            .sink { [weak self] carID in
                self?.openCarDetails(carID: carID)
            }
            .store(in: &bag)
    }
    
    // MARK: - Inherited Methods
    override func start() {
        setupMainController()
    }
    
    // MARK: - Private Methods
    private func setupMainController() {
        window.changeRootViewController(to: rootViewController)
        window.rootViewController = SwipeNavigationController(rootViewController: self.rootViewController) 
        window.makeKeyAndVisible()
    }
    
    private func openCarDetails(carID: Int) {
        let coordinator = CarDetailsCoordinator(container, carID: carID)
        coordinator.controller.hidesBottomBarWhenPushed = true
        PushRouter(target: coordinator.controller, parent: rootViewController).move()
        coordinate(to: coordinator)
    }
}

