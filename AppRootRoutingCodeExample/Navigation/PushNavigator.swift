//
//  PushNavigator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

/// Handles applying the navigation state of a `NavigationStack` object to a `UINavigationController`
public class PushNavigator {
    public var navigationController: UINavigationController?

    /// view controller used for presenting other view controllers
    public var presentingViewController: UIViewController?

    public init(navigationController: UINavigationController? = nil) {
        self.navigationController = navigationController
    }

    public func show(navigationStack: NavigationStack) {
        setViewControllers(from: navigationStack)
        present(navigationStack)
    }

    private func setViewControllers(from navigationStack: NavigationStack) {
        guard
            let pushed = navigationStack.pushed,
            pushed != navigationController?.viewControllers
        else {
            return
        }

        let isAnimated = navigationStack.presented.isEmpty
        navigationController?.setViewControllers(pushed, animated: isAnimated)
    }

    private func present(_ navigationStack: NavigationStack) {
        guard let presentingViewController = presentingViewController else { return }
        present(presented: navigationStack.presented, on: presentingViewController)
    }

    private func present(presented: [UIViewController], on presenting: UIViewController) {
        guard !presented.isEmpty else {
            if presenting.presentedViewController != nil, presenting.presentedViewController?.isBeingDismissed == false {
                presenting.dismiss(animated: true)
            }
            return
        }

        var mutablePresented = presented
        let next = mutablePresented.remove(at: 0)

        present(next, on: presenting, animated: mutablePresented.isEmpty) {
            self.present(presented: mutablePresented, on: next)
        }
    }

    private func present(_ presented: UIViewController,
                         on viewController: UIViewController,
                         animated: Bool,
                         completion: @escaping () -> Void) {
        guard viewController.presentedViewController !== presented else {
            completion()
            return
        }

        if viewController.presentedViewController != nil {
            viewController.dismiss(animated: false) {
                viewController.present(presented, animated: animated, completion: completion)
            }
        } else {
            viewController.present(presented, animated: animated, completion: completion)
        }
    }
}
