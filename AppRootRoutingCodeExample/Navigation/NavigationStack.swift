//
//  NavigationStack.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

/// Object representing a navigation stack that should be displayed by another router.
public struct NavigationStack: Equatable {
    public static func + (lhs: NavigationStack, rhs: NavigationStack) -> NavigationStack {
        let pushed: [UIViewController]?
        if lhs.pushed == nil, rhs.pushed == nil {
            pushed = nil
        } else {
            pushed = (lhs.pushed ?? []) + (rhs.pushed ?? [])
        }

        return .init(pushed: pushed, presented: lhs.presented + rhs.presented)
    }

    public static func += (lhs: inout NavigationStack, rhs: NavigationStack) {
        lhs = lhs + rhs
    }

    public static func presented(_ viewController: UIViewController) -> NavigationStack {
        return .init(presented: [viewController])
    }

    public static func pushed(_ viewController: UIViewController) -> NavigationStack {
        return .init(pushed: [viewController])
    }

    /// View controllers that should be pushed onto a navigation stack.
    /// Use `nil` to express that no change of the current stack should be performed.
    public let pushed: [UIViewController]?

    /// view controllers that should be displayed modally, last object in array it most top displayed view controller.
    public let presented: [UIViewController]

    public init(pushed: [UIViewController]? = nil, presented: [UIViewController] = []) {
        self.pushed = pushed
        self.presented = presented
    }
}
