//
//  LoadingViewController.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.2020.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

enum AppState {
    case authorized
    case unauthorized
}

protocol LoadingDelegate: AnyObject {
    func showContent(sender: LoadingViewController, appState: AppState)
}

class LoadingViewController: UIViewController {
    private var timer = Timer()
    private weak var delegate: LoadingDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer = Timer.scheduledTimer(timeInterval: 5,
                                     target: self,
                                     selector: #selector(showContent),
                                     userInfo: nil,
                                     repeats: false)
    }
    
    @objc
    private func showContent() {
        delegate?.showContent(sender: self, appState: .authorized)
    }
}

extension LoadingViewController {
    static func build(delegate: LoadingDelegate) -> LoadingViewController {
        let viewController = LoadingViewController.instantiateFromStoryboard(withName: "Loading")
        viewController.delegate = delegate
        return viewController
    }
}


