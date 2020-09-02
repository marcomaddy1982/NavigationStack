//
//  TabBarCoordinator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 31.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

final class TabBarCoordinator: NSObject, Coordinatable {
    var childCoordinators: [Coordinatable] = []
    var rootViewController: UIViewController { navigator.navigationController }

    let navigator: NavigatorProtocol
    private let tabBarController: TabBarController

    init(navigator: NavigatorProtocol, tabBarController: TabBarController) {
        self.navigator = navigator
        self.tabBarController = tabBarController

        navigator.navigationController.modalPresentationStyle = .fullScreen
    }

    func start(animated: Bool) {
        navigator.root(tabBarController, animated: animated)
    }
}
