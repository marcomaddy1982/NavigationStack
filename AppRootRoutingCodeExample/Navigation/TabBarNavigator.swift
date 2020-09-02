//
//  TabBarNavigator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 31.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol TabBarNavigatorDelegate: AnyObject {
    func pushNavigator(forTabAtIndex index: Int, sender: TabBarNavigator) -> PushNavigator
    func initialViewControllers(sender: TabBarNavigator) -> [UIViewController]
}

final class TabBarNavigator: NSObject {
    weak var delegate: TabBarNavigatorDelegate?
    weak var tabBarController: UITabBarController?

    func setup() {
        let navigationControllers = delegate?.initialViewControllers(sender: self)
        tabBarController?.setViewControllers(navigationControllers, animated: false)
        tabBarController?.delegate = self
    }

    /// Perform a navigation state change.
    ///
    /// - Parameters:
    ///   - navigationStack: The new naviation state to apply
    ///   - index: The index of the navigation controller inside `tabBarController`.
    func show(navigationStack: NavigationStack, at index: Int) {
        if navigationStack.pushed != nil {
            tabBarController?.selectedIndex = index
        }
        delegate?.pushNavigator(forTabAtIndex: index, sender: self).show(navigationStack: navigationStack)
    }

    /// Resets the navigator.
    ///
    /// Replaces all tabs, giving their view controllers a chance to dealloc.
    /// Presented controllers stay as they are.
    func reset() {
        tabBarController?.viewControllers = nil
        setup()
        // Note: resetting before setup() doesn't work.
        tabBarController?.selectedIndex = 0
    }
}

extension TabBarNavigator: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {
        if viewController === tabBarController.selectedViewController {
            (viewController.children.first as? UINavigationController)?.popToRootViewController(animated: true)
        }
        return true
    }
}
