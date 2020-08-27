//
//  UIView+Embed.swift
//  AppRootRoutingCodeExample
//
//  Created by Marco Maddalena on 26.08.20.
//  Copyright © 2020 Wire. All rights reserved.
//

import UIKit

public protocol EmbeddingGuide {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }
}

extension UILayoutGuide: EmbeddingGuide {}
extension UIView: EmbeddingGuide {}

extension UIView {
    public func embed(subview: UIView, aligningTo guide: EmbeddingGuide) {
        addSubview(subview)

        subview.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            subview.topAnchor.constraint(equalTo: guide.topAnchor),
            subview.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            subview.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            subview.trailingAnchor.constraint(equalTo: guide.trailingAnchor)
            ])
    }

    /// Insert UI data from from a specified nib as a subview.
    ///
    /// - Parameters:
    ///   - nibName: name of the nib to load
    ///   - bundle: bundle where the nib is located, defaults to main bundle
    ///   - guide: view or layout guide to aling the new subview, defaults to view itself
    public func embedView(ofNibNamed nibName: String, bundle maybeBundle: Bundle? = nil, aligningTo maybeGuide: EmbeddingGuide? = nil) {
        let bundle = maybeBundle ?? .main
        let guide = maybeGuide ?? self
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            fatalError("Could not instantiate '\(nibName)' inside '\(bundle)'")
        }

        embed(subview: view, aligningTo: guide)
    }
}
