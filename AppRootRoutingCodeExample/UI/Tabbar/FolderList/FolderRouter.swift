//
//  FolderRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

// MARK: - Class FolderMasterRouter

class FolderMasterRouter {
    private let folderListRouter: FolderListRouter
    
    init() {
        folderListRouter = FolderListRouter()
    }
}

// MARK: - Module Protocol

extension FolderMasterRouter: ModuleProtocol {
    public func buildNavigationController() -> UINavigationController {
        let navigationController = NoBackTitleNavigationController(rootViewController: folderListRouter.viewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Folder"
        tabBarItem.accessibilityIdentifier = "Folder"
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

// MARK: - Class FolderListRouter

class FolderListRouter {
    private let builder: FolderListWireFrame
    private weak var _viewController: FolderListViewController?
    
    init() {
        builder = FolderListWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

// MARK: - FolderListDelegate

extension FolderListRouter: FolderListDelegate {
    func showFolder(sender: FolderListViewController) { }
}

struct FolderListWireFrame {
    func build(delegate: FolderListDelegate) -> FolderListViewController {
        let viewController = FolderListViewController.instantiateFromStoryboard(withName: "FolderList")
        viewController.delegate = delegate
        return viewController
    }
}
