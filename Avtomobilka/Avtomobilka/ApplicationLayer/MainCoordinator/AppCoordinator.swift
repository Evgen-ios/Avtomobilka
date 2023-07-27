//
//  AppCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit

class AppCoordinator: BaseCoordinator<UINavigationController> {
    
    private var window: UIWindow!
    private var bag: CancelBag = .init()
    
    override init(_ container: DIContainer) {
        super.init(container)
    }
    
    override func start() {
        let coordinator = CarsListCoordinator(container, window: window ?? UIWindow())
        self.coordinate(to: coordinator)
    }
}

