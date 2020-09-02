//
//  TabBarController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 31.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
