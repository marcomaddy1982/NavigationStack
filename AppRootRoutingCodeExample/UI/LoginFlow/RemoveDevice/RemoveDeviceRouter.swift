//
//  RemoveDeviceRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class RemoveDeviceRouter {
    private var navigator: NavigatorProtocol
    private let builder: RemoveDeviceWireFrame
    private weak var _viewController: RemoveDeviceViewController?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = RemoveDeviceWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension RemoveDeviceRouter: RemoveDeviceDelegate {
    func showTabbar(sender: RemoveDeviceViewController) {
        let scene = UIApplication.shared.connectedScenes.first
        guard
            let sceneDelegate: SceneDelegate = (scene?.delegate as? SceneDelegate),
            let appStartCoordinator = sceneDelegate.appStartCoordinator
        else {
            return
        }
        
        appStartCoordinator.showTabbar()
    }
}

struct RemoveDeviceWireFrame {
    func build(delegate: RemoveDeviceDelegate) -> RemoveDeviceViewController {
        let viewController = RemoveDeviceViewController.instantiateFromStoryboard(withName: "RemoveDevice")
        viewController.delegate = delegate
        return viewController
    }
}
