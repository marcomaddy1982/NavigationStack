//
//  ViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol SearchDelegate: AnyObject {
    func showContactDetail(sender: SearchViewController)
}

class SearchViewController: UIViewController {
    weak var delegate: SearchDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func finishRegistrationButtonTouchUpInside(_ sender: Any) {
        delegate?.showContactDetail(sender: self)
    }
}
