//
//  LoginViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol LoginDelegate: AnyObject {
    func showContent(sender: LoginViewController)
    func showError(sender: LoginViewController)
}

class LoginViewController: UIViewController {

    weak var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func loginSuccessButtonTouchUpInside(_ sender: Any) {
        delegate?.showContent(sender: self)
    }
    
    @IBAction private func loginErrorButtonTouchUpInside(_ sender: Any) {
        delegate?.showError(sender: self)
    }
}

