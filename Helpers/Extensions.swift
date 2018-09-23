//
//  Extensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/15/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UIButton {
    static func buttonForTitle(_ title: String, image: UIImage,
                               titleColor: UIColor = .buttonTitleColor,
                               font: UIFont = .boldSystemFont(ofSize: 14),
                               titleEdgeInsets: UIEdgeInsets =
                                    UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.setImage(image, for: .normal)
        button.titleEdgeInsets = titleEdgeInsets
        button.titleLabel?.font = font
        return button
    }
}

extension UIImage {

    typealias RectCalculationClosure = (_ parentSize: CGSize, _ newImageSize: CGSize) -> (CGRect)
    func with(image named: String, rectCalculation: RectCalculationClosure) -> UIImage {
        return with(image: UIImage(named: named), rectCalculation: rectCalculation)
    }

    func with(image: UIImage?, rectCalculation: RectCalculationClosure) -> UIImage {

        if let image = image {
            UIGraphicsBeginImageContext(size)

            draw(in: CGRect(origin: .zero, size: size))
            image.draw(in: rectCalculation(size, image.size))

            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return newImage!
        }
        return self
    }
}

extension CGRect {
    static func estimatedBoundingRectWithString(_ string: String, width: CGFloat, attributes: [NSAttributedString.Key: Any]? = nil) -> CGRect {
        let size = CGSize(width: width, height: .infinity)
        return NSString(string: string).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
    }
}
