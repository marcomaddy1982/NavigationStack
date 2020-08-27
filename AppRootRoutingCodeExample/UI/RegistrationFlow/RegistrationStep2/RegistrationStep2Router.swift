//
//  RegistrationStep2Router.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class RegistrationStep2Router {
    private var navigator: NavigatorProtocol
    private let builder: RegistrationStep2WireFrame
    private weak var _viewController: RegistrationStep2ViewController?
    
    private var registrationStep3Router: RegistrationStep3Router?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = RegistrationStep2WireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension RegistrationStep2Router: RegistrationStep2Delegate {
    func showRegistrationStep3(sender: RegistrationStep2ViewController) {
        registrationStep3Router = RegistrationStep3Router(navigator: navigator)
        guard let viewController = registrationStep3Router?.viewController else { return }
        navigator.push(viewController)
    }
}

struct RegistrationStep2WireFrame {
    func build(delegate: RegistrationStep2Delegate) -> RegistrationStep2ViewController {
        let viewController = RegistrationStep2ViewController.instantiateFromStoryboard(withName: "RegistrationStep2")
        viewController.delegate = delegate
        return viewController
    }
}
