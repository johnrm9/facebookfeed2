//
//  UIColorExtensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UIColor {
    static let facebookBlue = UIColor(named: Constants.facebookBlue) ?? .rgb(r: 51, g: 90, b: 149)
    static let tabBarTintColor = UIColor.rgb(r: 70, g: 146, b: 250)
    static let backgroundColor = UIColor(named: Constants.backgroundColor) ?? UIColor(white: 0.95, alpha: 1)
    static let dividerLineColor = UIColor(named: Constants.dividerLineColor) ?? .rgb(r: 226, g: 228, b: 232)
    static let buttonTitleColor = UIColor(named: Constants.buttonTitleColor) ?? .rgb(r: 143, g: 150, b: 163)
    static let likesCommentColor = UIColor(named: Constants.likesCommentColor) ?? .rgb(r: 155, g: 161, b: 171)
    static let infoLineColor = UIColor(named: Constants.infoLineColor) ?? .rgb(r: 155, g: 161, b: 171)
    static let separatorColor = UIColor.rgb(r: 229, g: 231, b: 23)
    static let buttonBackgroundColor = UIColor.rgb(r: 87, g: 143, b: 255)
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
