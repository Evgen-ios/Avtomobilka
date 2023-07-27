//
//  CarsListCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit

class CarsListCoordinator: BaseCoordinator<CarsListViewController> {
    private var bag = CancelBag()
    private var window: UIWindow
    
    // MARK: - Inherited Methods
    init(_ container: DIContainer, window: UIWindow) {
        self.window = window
        
        super.init(container)
        rootViewController = CarsListAssembly.createModule(container)
    }
    
    override func start() {
        setupMainController()
    }
    
    private func setupMainController() {
        window.changeRootViewController(to: rootViewController)
        window.makeKeyAndVisible()
    }

}

