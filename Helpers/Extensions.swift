//
//  Extensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/15/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UIImage {

    typealias RectCalculationClosure = (_ parentSize: CGSize, _ newImageSize: CGSize)->(CGRect)
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

extension Int { var spaces: String { return String(repeating: " ", count: self) } }

extension NSMutableAttributedString {
    func setLineSpacing(_ spacing: CGFloat = 0) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, self.length))
        return self
    }
}

extension NSMutableAttributedString {
    func attachImage(_ image: UIImage, bounds: CGRect) -> NSMutableAttributedString {
        let attachment = NSTextAttachment()
        attachment.image = image
        attachment.bounds = bounds
        append(NSAttributedString(attachment: attachment))
        return self
    }
}

extension CGRect {
    static func estimatedBoundingRectWithString(_ string: String, width: CGFloat, attributes: [NSAttributedStringKey: Any]? = nil) -> CGRect {
        let size = CGSize(width: width, height: .infinity)
        return NSString(string: string).boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: attributes, context: nil)
    }
}

extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
extension UIView{
    func addSubviews(_ views: UIView...){
        views.forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}

extension UIView {

    func addConstraints(withVisualFormat format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()

        views.enumerated().forEach{
            let (key, view) =  ("v\($0.0)", $0.1)
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: [], metrics: nil, views: viewsDictionary))
    }
}


