//
//  RemoveDeviceViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol RemoveDeviceDelegate: AnyObject {
    func showTabbar(sender: RemoveDeviceViewController)
}

class RemoveDeviceViewController: UIViewController {

    weak var delegate: RemoveDeviceDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func showTabbarButtonTouchUpInside(_ sender: Any) {
        delegate?.showTabbar(sender: self)
    }
}
