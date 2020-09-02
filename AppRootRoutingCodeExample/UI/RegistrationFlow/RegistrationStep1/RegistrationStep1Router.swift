//
//  RegistrationStep1Router.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class RegistrationStep1Router {
    private var navigator: NavigatorProtocol
    private let builder: RegistrationStep1WireFrame
    private weak var _viewController: RegistrationStep1ViewController?
    
    private var registrationStep1Router: RegistrationStep2Router?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = RegistrationStep1WireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension RegistrationStep1Router: RegistrationStep1Delegate {
    func showRegistrationStep2(sender: RegistrationStep1ViewController) {
        registrationStep1Router = RegistrationStep2Router(navigator: navigator)
        guard let viewController = registrationStep1Router?.viewController else { return }
        navigator.push(viewController)
    }
}

struct RegistrationStep1WireFrame {
    func build(delegate: RegistrationStep1Delegate) -> RegistrationStep1ViewController {
        let viewController = RegistrationStep1ViewController.instantiateFromStoryboard(withName: "RegistrationStep1")
        viewController.delegate = delegate
        return viewController
    }
}
