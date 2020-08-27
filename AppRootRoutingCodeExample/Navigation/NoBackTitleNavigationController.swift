//
//  NoBackTitleNavigationController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public final class NoBackTitleNavigationController: UINavigationController {
    public override var viewControllers: [UIViewController] {
        didSet {
            viewControllers.forEach(shouldHideBackButton(for:))
        }
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)

        shouldHideBackButton(for: viewController)
    }

    public override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
        super.setViewControllers(viewControllers, animated: animated)

        viewControllers.forEach(shouldHideBackButton(for:))
    }

    private func shouldHideBackButton(for viewController: UIViewController) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "",
                                                                          style: .plain,
                                                                          target: nil,
                                                                          action: nil)
    }
}
