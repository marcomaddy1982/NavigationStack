//
//  RegistrationStep3ViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol RegistrationStep3Delegate: AnyObject {
    func showFinishRegistration(sender: RegistrationStep3ViewController)
}

class RegistrationStep3ViewController: UIViewController {
    weak var delegate: RegistrationStep3Delegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func finishRegistrationButtonTouchUpInside(_ sender: Any) {
        delegate?.showFinishRegistration(sender: self)
    }
}
