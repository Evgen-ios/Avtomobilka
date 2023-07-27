//
//  Coordinator.swift
//  Avtomobilka
//
//  Created by Evgeniy Goncharov on 25.07.2023.
//

import Foundation
import UIKit
import DITranquillity

protocol BaseCoordinatorRoutable {
    var controller: UIViewController { get }
}

class BaseCoordinator<T>: Coordinator where T: UIViewController {
    var rootViewController: T! {
        set { plainRootViewController = newValue }
        get { plainRootViewController as? T }
    }
}

extension BaseCoordinator: BaseCoordinatorRoutable {
    var controller: UIViewController {
        get {
            rootViewController
        }
    }
}

class Coordinator: NSObject {
    
    let container: DIContainer

    fileprivate weak var weakRootViewController: UIViewController?
    fileprivate var strongRootViewController: UIViewController?

    var plainRootViewController: UIViewController? {
        set {
            strongRootViewController = newValue
            weakRootViewController = newValue
            weakRootViewController?.coordinator = self
        }
        get {
            return weakRootViewController
        }
    }

    private let identifier = UUID()
    private var childCoordinators = NSMapTable<NSUUID, Coordinator>(keyOptions: .strongMemory, valueOptions: .weakMemory)
    private(set) weak var topCoordinator: Coordinator?

    init(_ container: DIContainer) {
        self.container = container
    }

    private func store(coordinator: Coordinator) {
        childCoordinators.setObject(coordinator, forKey: coordinator.identifier as NSUUID)
        topCoordinator = coordinator
    }

    func free(coordinator: Coordinator) {
        coordinator.plainRootViewController?.coordinator = nil
        childCoordinators.removeObject(forKey: coordinator.identifier as NSUUID)

        coordinator.childCoordinators.objectEnumerator()?.forEach({ (childCoordinator) in
            if let childCoordinator = childCoordinator as? Coordinator {
                coordinator.free(coordinator: childCoordinator)
            }
        })
    }

    func coordinate(to coordinator: Coordinator) {
        store(coordinator: coordinator)
        coordinator.start()
        coordinator.freeReferences()
    }

    func freeReferences() {
        strongRootViewController = nil
    }

    func start() {
        fatalError("Start method should be implemented.")
    }
}

private extension UIViewController {

    private struct AssociatedKeys {
        static var coordinator: UInt8 = 0
    }

    var coordinator: Coordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.coordinator) as? Coordinator
        }

        set {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.coordinator,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
}

