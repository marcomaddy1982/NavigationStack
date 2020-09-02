//
//  FolderListViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol FolderListDelegate: AnyObject {
    func showFolder(sender: FolderListViewController)
}

class FolderListViewController: UIViewController {
    weak var delegate: FolderListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
