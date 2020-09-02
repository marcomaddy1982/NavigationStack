//
//  Coordinator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public protocol Coordinatable: AnyObject {
    var childCoordinators: [Coordinatable] { get set }
    var navigator: NavigatorProtocol { get }

    func start(animated: Bool)
}

public extension Coordinatable {
    func appendChildCoordinator(_ childCoordinator: Coordinatable) {
        childCoordinators.append(childCoordinator)
    }

    func removeChildCoordinator(_ childCoordinator: Coordinatable) {
        childCoordinators = childCoordinators.filter { $0 !== childCoordinator }
    }
}

public extension Coordinatable {
    var rootViewController: UINavigationController { navigator.navigationController }

    func presentCoordinator(_ childCoordinator: Coordinatable, animated: Bool = true, completion: (() -> Void)? = nil) {
        appendChildCoordinator(childCoordinator)
        childCoordinator.start(animated: false)
        rootViewController.present(childCoordinator.rootViewController, animated: animated, completion: completion)
    }

    func dismissCoordinator(_ childCoordinator: Coordinatable, animated: Bool = true, completion: (() -> Void)? = nil) {
        childCoordinator.rootViewController.dismiss(animated: animated, completion: completion)
        removeChildCoordinator(childCoordinator)
    }

    /// For use when letting a child coordinator push onto the same navigator this coordinator is using.
    /// In order for cleanup to work properly, `childViewController` **must** push a view controller onto the navigator inside `start`!
    func startCoordinator(_ childCoordinator: Coordinatable, animated: Bool) {
        let viewControllersBeforeStart = navigator.navigationController.viewControllers

        appendChildCoordinator(childCoordinator)
        childCoordinator.start(animated: animated)

        let addedViewControllers = navigator.navigationController.viewControllers.filter {
            !viewControllersBeforeStart.contains($0)
        }

        guard let viewControllerToTrack = addedViewControllers.first else {
            assertionFailure("Unable to setup coordinator cleanup – no view controller got pushed by \(childCoordinator)!")
            return
        }

        print("setting up cleanup for \(childCoordinator) using \(viewControllerToTrack)")

        let closure: NavigateBackClosure = { [weak self, weak childCoordinator] in
            
            guard let childCoordinator = childCoordinator else { return }

            print("removing childCoordinator \(childCoordinator)")
            self?.removeChildCoordinator(childCoordinator)
        }
        navigator.addNavigateBack(closure: closure, for: viewControllerToTrack)
    }
}
