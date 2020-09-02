//
//  AppStartCoordinator.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 25.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

final class AppStartCoordinator: Coordinatable {
    private var loginRouter: LoginRouter?
    private var registrationRouter: RegistrationStep1Router?
    private let appRouter: AppRouter = AppRouter()
    
    let navigator: NavigatorProtocol
    var rootViewController: UIViewController { navigator.navigationController }
    var childCoordinators: [Coordinatable] = []

    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
    }

    func start(animated: Bool) {
        let loadingViewController = LoadingViewController.build(delegate: self)
        navigator.root(loadingViewController, animated: animated)
        
        observeNavigationNotifications()
    }
    
    func showTabbar() {
        appRouter.start(navigator: navigator, animated: true)
    }
    
    deinit {
        removeObserveNavigationNotifications()
    }
}

extension AppStartCoordinator {
    private func observeNavigationNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(pushNewScreen),
                                               name: NSNotification.Name(rawValue: NotificationName.pushScreen.rawValue),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(presentNewScreen),
                                               name: NSNotification.Name(rawValue: NotificationName.presentScreen.rawValue),
                                               object: nil)
    }
    
    private func removeObserveNavigationNotifications() {
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: NotificationName.pushScreen.rawValue),
                                                  object: nil)
        
        NotificationCenter.default.removeObserver(self,
                                                  name: NSNotification.Name(rawValue: NotificationName.presentScreen.rawValue),
                                                  object: nil)
    }
    
    @objc
    private func pushNewScreen() {
        let pushNavigator = PushNavigator(navigationController: navigator.navigationController)
        
        let viewController = UIViewController()
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.backgroundColor = .red
        
        let stackControllers = navigator.navigationController.viewControllers + [viewController]
        
        let navigationStack = NavigationStack(pushed: stackControllers)
        pushNavigator.show(navigationStack: navigationStack)
    }
    
    @objc
    private func presentNewScreen() {
        let pushNavigator = PushNavigator(navigationController: navigator.navigationController)
        pushNavigator.presentingViewController = rootViewController
        
        let viewController = UIViewController()
        viewController.view.frame = UIScreen.main.bounds
        viewController.view.backgroundColor = .red

        let navigationStack = NavigationStack(presented: [viewController])
        pushNavigator.show(navigationStack: navigationStack)
    }
}

extension AppStartCoordinator: LoadingDelegate {
    func showContent(sender: LoadingViewController, appState: AppState) {
        switch appState {
        case .unauthorized:
            showLoginSetup()
        case .authorized:
            showTabbar()
        }
    }
    
    private func showLoginSetup() {
        let pushNavigator = PushNavigator(navigationController: navigator.navigationController)
        let loginSetupViewController = LoginSetupViewController.build(delegate: self)
        let navigationStack = NavigationStack(pushed: [loginSetupViewController])
        pushNavigator.show(navigationStack: navigationStack)
    }
}

extension AppStartCoordinator: LoginSetupDelegate {
    func showLogin(sender: LoginSetupViewController) {
        loginRouter = LoginRouter(navigator: navigator)
        guard let viewController = loginRouter?.viewController else { return }
        navigator.push(viewController)
    }
    
    func showRegistration(sender: LoginSetupViewController) {
        registrationRouter = RegistrationStep1Router(navigator: navigator)
        guard let viewController = registrationRouter?.viewController else { return }
        navigator.push(viewController)
    }
}
