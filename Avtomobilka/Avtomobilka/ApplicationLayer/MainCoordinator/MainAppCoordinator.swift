//
//  MainAppCoordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit
import MintLogger

open class MainAppCoordinator: Loggable {
    
    public var defaultLoggingTag: LogTag {
        return .unnamed
    }
    
    private var bag: CancelBag = .init()
    
    public static var shared: MainAppCoordinator!

    open var configuration: DependenciesConfiguration
    open var container: DIContainer

    private let appCoordinator: AppCoordinator
    
    init(configuration: DependenciesConfiguration) {
        self.configuration = configuration
        self.configuration.setup()
        self.container = self.configuration.configuredContainer()
        self.appCoordinator = AppCoordinator(container)
    }

    func start() {
        appCoordinator.start()
    }
}
