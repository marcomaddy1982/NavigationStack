//
//  ConversationListViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 02.09.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol ConversationListDelegate: AnyObject {
    func showConversation(sender: ConversationListViewController)
}

class ConversationListViewController: UIViewController {
    weak var delegate: ConversationListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
