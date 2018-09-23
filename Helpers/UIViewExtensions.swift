//
//  UIViewExtensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UIView {

    func addConstraints(withVisualFormat format: String, metrics: [String: Any]? = nil, views: UIView...) {
        var viewsDictionary = [String: UIView]()

        views.enumerated().forEach {
            let (key, view) =  ("v\($0.0)", $0.1)
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [],
                                                      metrics: metrics,
                                                      views: viewsDictionary))
    }
}

extension UIView {
    static func toggleAlphas(views: UIView...) {
        views.forEach {$0.toggleAlpha()}
    }
    func toggleAlpha() {
        self.alpha = 1 - self.alpha
    }
}

extension UIView {
    static func separatorView(_ backgroundColor: UIColor = UIColor(white: 0, alpha: 0.5)) -> UIView {
        let view = UIView()
        view.backgroundColor = backgroundColor
        return view
    }
}
