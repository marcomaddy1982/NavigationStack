//
//  ArchiveListViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol ArchiveListDelegate: AnyObject {
    func showArchived(sender: ArchiveListViewController)
}

class ArchiveListViewController: UIViewController {
    weak var delegate: ArchiveListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
