//
//  NavigationControllerDelegate.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public final class CompositeNavigationBehavior: NSObject {
    private let delegates: [UINavigationControllerDelegate]

    public init(_ packedDelegates: [UINavigationControllerDelegate?] = []) {
        delegates = packedDelegates
            .flatMap { (delegate: UINavigationControllerDelegate?) -> [UINavigationControllerDelegate] in

                // Unpack all existing composite delegates so that we don't create unnecessary hierarchy levels.

                if let composite = delegate as? CompositeNavigationBehavior {
                    return composite.delegates
                } else if let delegate = delegate {
                    return [delegate]
                } else {
                    return []
                }
            }
    }
}

extension CompositeNavigationBehavior: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        for delegate in delegates {
            delegate.navigationController?(navigationController,
                                           willShow: viewController, animated: animated)
        }
    }

    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        for delegate in delegates {
            delegate.navigationController?(navigationController,
                                           didShow: viewController, animated: animated)
        }
    }
}

// Don't forget to strongly hold the result.
// swiftlint:disable:next static_operator
public func + (_ lhs: UINavigationControllerDelegate, _ rhs: UINavigationControllerDelegate?) -> CompositeNavigationBehavior {
    return CompositeNavigationBehavior([lhs, rhs])
}
