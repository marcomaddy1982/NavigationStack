//
//  RegistrationStep3Router.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class RegistrationStep3Router {
    private var navigator: NavigatorProtocol
    private let builder: RegistrationStep3WireFrame
    private weak var _viewController: RegistrationStep3ViewController?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = RegistrationStep3WireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension RegistrationStep3Router: RegistrationStep3Delegate {
    func showFinishRegistration(sender: RegistrationStep3ViewController) {
        let scene = UIApplication.shared.connectedScenes.first
        guard
            let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate),
            let appStartCoordinator = sceneDelegate.appStartCoordinator
        else {
            return
        }
        
        let pushNavigator = PushNavigator(navigationController: navigator.navigationController)
        let loginSetupViewController = LoginSetupViewController.build(delegate: appStartCoordinator)
        let loginViewController = LoginRouter(navigator: navigator).viewController
        
//        pushNavigator.presentingViewController = navigator.navigationController
//        let viewController = UIViewController()
//        viewController.view.frame = UIScreen.main.bounds
//        viewController.view.backgroundColor = .red
        
        let navigationStack = NavigationStack(pushed: [loginSetupViewController, loginViewController])
        
        pushNavigator.show(navigationStack: navigationStack)
    }
}

struct RegistrationStep3WireFrame {
    func build(delegate: RegistrationStep3Delegate) -> RegistrationStep3ViewController {
        let viewController = RegistrationStep3ViewController.instantiateFromStoryboard(withName: "RegistrationStep3")
        viewController.delegate = delegate
        return viewController
    }
}
