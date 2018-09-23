//
//  AttributedStringExtensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension CGRect {
    static let shared = CGRect()

    var smallImageFrame: CGRect {
        //return CGRect(origin: .zero, size: CGSize(width: 12, height: 12))
        return zeroOrigin(with: CGSize(width: 12, height: 12))
    }

    func  offSetByY(dy: CGFloat ) -> CGRect {
        return self.offsetBy(dx: 0, dy: dy)
    }

    func  offSetByX(_ dx: CGFloat ) -> CGRect {
        return self.offsetBy(dx: dx, dy: 0)
    }

    func zeroOrigin(with size: CGSize) -> CGRect {
        return CGRect(origin: .zero, size: size)
    }
}

extension NSMutableAttributedString {
    func setLineSpacing(_ spacing: CGFloat = 0) -> NSMutableAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: self.length))
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
