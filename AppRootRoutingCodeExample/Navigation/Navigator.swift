//
//  Navigator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public typealias NavigateBackClosure = () -> Void

public protocol NavigatorProtocol {
    var navigationController: UINavigationController { get }

    func push(_ viewController: UIViewController, animated: Bool, onNavigateBack: NavigateBackClosure?)
    func pop(_ animated: Bool)
    func present(_ viewController: UIViewController, animated: Bool, onComplete: (() -> Void)?)
    func root(_ viewController: UIViewController, animated: Bool)
    func dismiss(_ viewController: UIViewController?, animated: Bool)

    func addNavigateBack(closure: @escaping NavigateBackClosure, for viewController: UIViewController)
}

public extension NavigatorProtocol {
    func push(_ viewController: UIViewController) {
        push(viewController, animated: true, onNavigateBack: nil)
    }

    func push(_ viewController: UIViewController, animated: Bool) {
        push(viewController, animated: animated, onNavigateBack: nil)
    }

    func present(_ viewController: UIViewController) {
        present(viewController, animated: true, onComplete: nil)
    }

    func root(_ viewController: UIViewController) {
        root(viewController, animated: true)
    }
}

public class Navigator: NSObject, NavigatorProtocol {
    public let navigationController: UINavigationController
    private var closures: [UIViewController: NavigateBackClosure] = [:]

    public init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        navigationController.delegate = self
    }

    public func push(_ viewController: UIViewController,
                     animated: Bool,
                     onNavigateBack: NavigateBackClosure? = nil) {
        if let closure = onNavigateBack {
            addNavigateBack(closure: closure, for: viewController)
        }
        navigationController.pushViewController(viewController, animated: animated)
    }

    public func pop(_ animated: Bool) {
        let vc = navigationController.popViewController(animated: animated)
        vc.flatMap { runCompletion(for: $0) }
    }

    public func dismiss(_ viewController: UIViewController?, animated: Bool) {
        guard let viewController = viewController else { return }
        runCompletion(for: viewController)
        viewController.dismiss(animated: animated, completion: nil)
    }

    public func present(_ viewController: UIViewController, animated: Bool, onComplete: (() -> Void)?) {
        navigationController.present(viewController, animated: animated, completion: onComplete)
    }

    public func root(_ viewController: UIViewController, animated: Bool) {
        closures.forEach { $0.value() }
        closures = [:]
        navigationController.viewControllers = [viewController]
    }

    public func addNavigateBack(closure: @escaping NavigateBackClosure,
                                for viewController: UIViewController) {
        print("adding closure for \(viewController)")
        closures.updateValue(closure, forKey: viewController)
    }

    private func runCompletion(for viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController) else {
            return
        }
        print("adding closure for \(viewController)")
        closure()
    }
}

extension Navigator: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                                     didShow viewController: UIViewController,
                                     animated: Bool) {
        guard
            let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController)
        else {
            return
        }
        runCompletion(for: previousController)
    }
}
