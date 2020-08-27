//
//  RegistrationStep1ViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol RegistrationStep1Delegate: AnyObject {
    func showRegistrationStep2(sender: RegistrationStep1ViewController)
}

class RegistrationStep1ViewController: UIViewController {

    weak var delegate: RegistrationStep1Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func registrationStep2ButtonTouchUpInside(_ sender: Any) {
        delegate?.showRegistrationStep2(sender: self)
    }
}
