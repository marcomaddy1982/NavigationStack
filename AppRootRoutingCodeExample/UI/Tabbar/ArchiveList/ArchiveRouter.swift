//
//  ArchiveRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

// MARK: - Class ArchiveMasterRouter

class ArchiveMasterRouter {
    private let archiveListRouter: ArchiveListRouter
    
    init() {
        archiveListRouter = ArchiveListRouter()
    }
}

// MARK: - Module Protocol

extension ArchiveMasterRouter: ModuleProtocol {
    public func buildNavigationController() -> UINavigationController {
        let navigationController = NoBackTitleNavigationController(rootViewController: archiveListRouter.viewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Archive"
        tabBarItem.accessibilityIdentifier = "Archive"
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

// MARK: - Class ArchiveListRouter

class ArchiveListRouter {
    private let builder: ArchiveListWireFrame
    private weak var _viewController: ArchiveListViewController?
    
    init() {
        builder = ArchiveListWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

// MARK: - ArchiveListDelegate

extension ArchiveListRouter: ArchiveListDelegate {
    func showArchived(sender: ArchiveListViewController) { }
}

struct ArchiveListWireFrame {
    func build(delegate: ArchiveListDelegate) -> ArchiveListViewController {
        let viewController = ArchiveListViewController.instantiateFromStoryboard(withName: "ArchiveList")
        viewController.delegate = delegate
        return viewController
    }
}
