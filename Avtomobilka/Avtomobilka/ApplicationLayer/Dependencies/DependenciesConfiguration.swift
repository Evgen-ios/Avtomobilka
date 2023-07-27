//
//  DependenciesConfiguration.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import DITranquillity
import UIKit

public protocol DependenciesConfiguration {
    func setup()
    func configuredContainer() -> DIContainer
}

open class DependenciesConfigurationBase: DependenciesConfiguration {
    private var options: [UIApplication.LaunchOptionsKey: Any]?
    
    init(launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        self.options = launchOptions
    }
    
    // MARK: - Configure
    
    public func configuredContainer() -> DIContainer {
        let container = DIContainer()
        container.append(framework: AppFramework.self)
        return container
    }
    
    // MARK: - Setup
    
    public func setup() {}
}
