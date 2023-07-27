//
//  CarsListCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit

class CarsListCoordinator: BaseCoordinator<CarsListViewController> {
    
    // MARK: - Properties
    private var bag = CancelBag()
    private var window: UIWindow
    
    // MARK: - Init
    init(_ container: DIContainer, window: UIWindow) {
        self.window = window
        
        super.init(container)
        rootViewController = CarsListAssembly.createModule(container)
    }
    
    // MARK: - Inherited Methods
    override func start() {
        setupMainController()
    }
    
    // MARK: - Private Methods
    private func setupMainController() {
        window.changeRootViewController(to: rootViewController)
        window.makeKeyAndVisible()
    }

}

