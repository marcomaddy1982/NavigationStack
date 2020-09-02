//
//  SearchRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 01.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

// MARK: - Class SearchMasterRouter

class SearchMasterRouter {
    private let searchRouter: SearchRouter
    
    init() {
        searchRouter = SearchRouter()
    }
}

// MARK: - Module Protocol

extension SearchMasterRouter: ModuleProtocol {
    public func buildNavigationController() -> UINavigationController {
        let navigationController = NoBackTitleNavigationController(rootViewController: searchRouter.viewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Search"
        tabBarItem.accessibilityIdentifier = "Search"
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

// MARK: - Class SearchRouter

class SearchRouter {
    private let builder: SearchWireFrame
    private weak var _viewController: SearchViewController?
    
    init() {
        builder = SearchWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

// MARK: - SearchDelegate

extension SearchRouter: SearchDelegate {
    func showContactDetail(sender: SearchViewController) {
        
    }
}

struct SearchWireFrame {
    func build(delegate: SearchDelegate) -> SearchViewController {
        let viewController = SearchViewController.instantiateFromStoryboard(withName: "Search")
        viewController.delegate = delegate
        return viewController
    }
}
