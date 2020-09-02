//
//  ModuleProtocol.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 01.09.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public protocol ModuleProtocol {
    /// Get a new navigation controller with correct root view controller for the module.
    func buildNavigationController() -> UINavigationController
}
