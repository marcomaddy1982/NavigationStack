//
//  RegistrationStep2ViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol RegistrationStep2Delegate: AnyObject {
    func showRegistrationStep3(sender: RegistrationStep2ViewController)
}

class RegistrationStep2ViewController: UIViewController {

    weak var delegate: RegistrationStep2Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func registrationStep3ButtonTouchUpInside(_ sender: Any) {
        delegate?.showRegistrationStep3(sender: self)
    }
}
