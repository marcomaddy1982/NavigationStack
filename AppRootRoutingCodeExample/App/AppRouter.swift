//
//  AppRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 01.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

private enum FeatureStack {
    case search
    case conversation
    case folder
    case archive
}

private typealias PendingNavigationStack = (FeatureStack, NavigationStack)

final class AppRouter {
    let tabBarController = TabBarController()
    
    private let navigator = TabBarNavigator()
    private var pushNavigators = [FeatureStack: PushNavigator]()
    private lazy var navigationBehavior: CompositeNavigationBehavior = buildNavigationBehavior()
    
    private let featureRouters: [(FeatureStack, ModuleProtocol)]
    private let searchMasterRouter: SearchMasterRouter
    private let conversationMasterRouter: ConversationMasterRouter
    private let floderMasterRouter: FolderMasterRouter
    private let archiveMasterRouter: ArchiveMasterRouter
    
    private var isStarted = false
    /// navigation stack being shown delayed due to app-startup
    private var pendingStack: PendingNavigationStack?

    private var childCoordinators: [Coordinatable] = []

    init() {
        searchMasterRouter = SearchMasterRouter()
        conversationMasterRouter = ConversationMasterRouter()
        floderMasterRouter = FolderMasterRouter()
        archiveMasterRouter = ArchiveMasterRouter()
        
        featureRouters = [
            (.search, searchMasterRouter),
            (.conversation, conversationMasterRouter),
            (.folder, floderMasterRouter),
            (.archive, archiveMasterRouter)
        ]
        
        setupDelegates() // The other routers could need a delegate that should be the AppRouter
        setupTabBar()
    }

    func start(navigator: NavigatorProtocol, animated: Bool) {
        let coordinator = TabBarCoordinator(
            navigator: navigator,
            tabBarController: tabBarController
        )
        childCoordinators.append(coordinator)
        coordinator.start(animated: animated)

        isStarted = true
        self.navigator.setup()

        showPendingStack()
    }

    private func setupTabBar() {
        tabBarController.definesPresentationContext = false
        navigator.tabBarController = tabBarController
    }

    private func setupDelegates() {
        navigator.delegate = self
    }
}

// MARK: - Navigation

extension AppRouter {
    private func show(navigationStack: NavigationStack, feature: FeatureStack) {
        guard isStarted else {
            pendingStack = (feature, navigationStack)
            return
        }

        guard let tabIndex = featureRouters.firstIndex(where: { $0.0 == feature }) else {
            print("I do not know where to display feature \(feature)")
            return
        }

        navigator.show(navigationStack: navigationStack, at: tabIndex)
    }

    private func showPendingStack() {
        guard let pending = self.pendingStack else { return }
        show(navigationStack: pending.1, feature: pending.0)
    }
}

// MARK: - Build

extension AppRouter {
    private func buildNavigationBehavior() -> CompositeNavigationBehavior {
        return CompositeNavigationBehavior([])
    }
}

// MARK: - TabBarNavigatorDelegate

extension AppRouter: TabBarNavigatorDelegate {
    func pushNavigator(forTabAtIndex index: Int, sender: TabBarNavigator) -> PushNavigator {
        guard let pushNavigator = pushNavigators[featureRouters[index].0] else { fatalError("Navigating using invalid tab index!") }
        return pushNavigator
    }

    func initialViewControllers(sender: TabBarNavigator) -> [UIViewController] {
        return featureRouters.map { feature, module in
            let navigationController = module.buildNavigationController()
            navigationController.delegate = navigationBehavior

            let navigator = PushNavigator(navigationController: navigationController)
            navigator.presentingViewController = tabBarController
            pushNavigators[feature] = navigator

            return navigationController
        }
    }
}

