//
//  ServiceMetrics.swift
//  facebookfeed2
//
//  Created by John Martin on 9/22/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension CGFloat {
    public init(_ value: NSNumber) {
        self = CGFloat(truncating: value)
    }
}

class ServiceMetrics {
    static let shared = ServiceMetrics()

    let profileImageHeight = NSNumber(value: 44)
    let statusImageViewHeight = NSNumber(value: 200)
    let likesCommentLabelHeight = NSNumber(value: 24)
    let likeButtonHeight = NSNumber(value: 44)

    let padding8 = NSNumber(value: 8)
    let padding4 = NSNumber(value: 4)
    let padding12 = NSNumber(value: 12)

    lazy var metrics: [String: Any] = [
        "p0": padding8,
        "p1": padding4,
        "p2": padding12,
        "ih0": profileImageHeight,
        "ih1": statusImageViewHeight,
        "lh0": likesCommentLabelHeight,
        "bh0": likeButtonHeight
    ]

    var knownHeight: CGFloat {
        //let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
        let knownHeight: CGFloat =
                CGFloat(padding8) +
                CGFloat(profileImageHeight) +
                CGFloat(padding4) +
                CGFloat(padding4) +
                CGFloat(statusImageViewHeight) +
                CGFloat(padding8) +
                CGFloat(likesCommentLabelHeight) +
                CGFloat(padding8) +
                CGFloat(likeButtonHeight)
        return knownHeight
    }
}
