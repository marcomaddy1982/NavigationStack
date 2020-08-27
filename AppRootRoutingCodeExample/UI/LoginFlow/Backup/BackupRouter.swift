//
//  BackupRouter.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

class BackupRouter {
    private var navigator: NavigatorProtocol
    private let builder: BackupWireFrame
    private weak var _viewController: BackupViewController?
    
    private var removeDeivceRouter: RemoveDeviceRouter?
    
    init(navigator: NavigatorProtocol) {
        self.navigator = navigator
        builder = BackupWireFrame()
    }
    
    var viewController: UIViewController {
        let viewController = _viewController ?? builder.build(delegate: self)
        _viewController = viewController
        return viewController
    }
}

extension BackupRouter: BackupDelegate {
    func showRemoveDevice(sender: BackupViewController) {
        removeDeivceRouter =  RemoveDeviceRouter(navigator: navigator)
        guard let viewController = removeDeivceRouter?.viewController else { return }
        navigator.push(viewController)
    }
}


struct BackupWireFrame {
    func build(delegate: BackupDelegate) -> BackupViewController {
        let viewController = BackupViewController.instantiateFromStoryboard(withName: "Backup")
        viewController.delegate = delegate
        return viewController
    }
}
