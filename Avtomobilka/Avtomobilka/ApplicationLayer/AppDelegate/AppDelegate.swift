//
//  AppDelegate.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 24.07.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication,didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let dependencyConfiguration = DependenciesConfigurationBase(launchOptions: launchOptions)
        let coordinator = MainAppCoordinator(configuration: dependencyConfiguration)
        MainAppCoordinator.shared = coordinator
        coordinator.start()
        return true
    }
}
