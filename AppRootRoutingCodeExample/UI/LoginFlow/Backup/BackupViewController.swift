//
//  BackupViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol BackupDelegate: AnyObject {
    func showRemoveDevice(sender: BackupViewController)
}

class BackupViewController: UIViewController {

    weak var delegate: BackupDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func removeDeviceButtonTouchUpInside(_ sender: Any) {
        delegate?.showRemoveDevice(sender: self)
    }
}
