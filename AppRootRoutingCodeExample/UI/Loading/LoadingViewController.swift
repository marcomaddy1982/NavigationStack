//
//  LoadingViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26/08/2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

protocol LoadingDelegate: AnyObject {
    func showLoginSetup(sender: LoadingViewController)
}

class LoadingViewController: UIViewController {
    private var timer = Timer()
    private weak var delegate: LoadingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 5,
                                     target: self,
                                     selector: #selector(showLoginSetup),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc
    private func showLoginSetup() {
        delegate?.showLoginSetup(sender: self)
    }
}

extension LoadingViewController {
    static func build(delegate: LoadingDelegate) -> LoadingViewController {
        let viewController = LoadingViewController.instantiateFromStoryboard(withName: "Loading")
        viewController.delegate = delegate
        return viewController
    }
}


