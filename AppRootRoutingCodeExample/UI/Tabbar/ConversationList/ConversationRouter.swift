//
//  ConversationRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

// MARK: - Class ConversationMasterRouter

class ConversationMasterRouter {
    private let conversationListRouter: ConversationListRouter
    
    init() {
        conversationListRouter = ConversationListRouter()
    }
}

// MARK: - Module Protocol

extension ConversationMasterRouter: ModuleProtocol {
    public func buildNavigationController() -> UINavigationController {
        let navigationController = NoBackTitleNavigationController(rootViewController: conversationListRouter.viewController)
        let tabBarItem = UITabBarItem()
        tabBarItem.title = "Conversation"
        tabBarItem.accessibilityIdentifier = "Conversation"
        navigationController.tabBarItem = tabBarItem
        return navigationController
    }
}

// MARK: - Class ConversationListRouter

class ConversationListRouter {
    private let builder: ConversationListWireFrame
    private weak var _viewController: ConversationListViewController?
    
    init() {
        builder = ConversationListWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

// MARK: - ConversationListDelegate

extension ConversationListRouter: ConversationListDelegate {
    func showConversation(sender: ConversationListViewController) {
        
    }
}

struct ConversationListWireFrame {
    func build(delegate: ConversationListDelegate) -> ConversationListViewController {
        let viewController = ConversationListViewController.instantiateFromStoryboard(withName: "ConversationList")
        viewController.delegate = delegate
        return viewController
    }
}
