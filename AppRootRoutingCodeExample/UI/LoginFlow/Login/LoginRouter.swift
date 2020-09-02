//
//  LoginRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class LoginRouter {
    private var navigator: NavigatorProtocol
    private let builder: LoginWireFrame
    private weak var _viewController: LoginViewController?
    
    private var backupRouter: BackupRouter?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = LoginWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension LoginRouter: LoginDelegate {
    func showContent(sender: LoginViewController) {
        backupRouter = BackupRouter(navigator: navigator)
        guard let viewController = backupRouter?.viewController else { return }
        navigator.push(viewController)
    }
    
    func showError(sender: LoginViewController) {
        let alert = UIAlertController(title: "Login",
                                      message: "wrong credentials",
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok",
                                      style: .default,
                                      handler: nil))
        navigator.present(alert)
    }
}


struct LoginWireFrame {
    func build(delegate: LoginDelegate) -> LoginViewController {
        let viewController = LoginViewController.instantiateFromStoryboard(withName: "Login")
        viewController.delegate = delegate
        return viewController
    }
}
