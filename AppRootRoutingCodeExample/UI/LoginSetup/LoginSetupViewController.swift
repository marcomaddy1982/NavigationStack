//
//  LoginSetupViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol LoginSetupDelegate: AnyObject {
    func showLogin(sender: LoginSetupViewController)
    func showRegistration(sender: LoginSetupViewController)
}

class LoginSetupViewController: UIViewController {

    private weak var delegate: LoginSetupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction private func loginButtonTouchUpInside(_ sender: Any) {
        delegate?.showLogin(sender: self)
        
//        NotificationDispatcher.shared.dispatchPushScreenNotification()
        NotificationDispatcher.shared.dispatchPresentScreenNotification()
    }
    
    @IBAction private func registrationButtonTouchUpInside(_ sender: Any) {
        delegate?.showRegistration(sender: self)
    }
}

extension LoginSetupViewController {
    static func build(delegate: LoginSetupDelegate) -> LoginSetupViewController {
        let viewController = LoginSetupViewController.instantiateFromStoryboard(withName: "LoginSetup")
        viewController.delegate = delegate
        return viewController
    }
}
