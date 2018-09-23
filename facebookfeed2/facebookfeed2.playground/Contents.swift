import UIKit
extension CGFloat {
    public init(_ value: NSNumber) {
        self = CGFloat(truncating: value)
    }
}

let profileImageHeight = NSNumber(value: 44)
let statusImageViewHeight = NSNumber(value: 200)
let likesCommentLabelHeight = NSNumber(value: 24)
let likeButtonHeight = NSNumber(value: 44)

let padding8 = NSNumber(value: 8)
let padding4 = NSNumber(value: 4)

let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
let metricsHeight: CGFloat = CGFloat(padding8) +
                             CGFloat(profileImageHeight) +
                             CGFloat(padding4) +
                             CGFloat(padding4) +
                             CGFloat(statusImageViewHeight) +
                             CGFloat(padding8) +
                             CGFloat(likesCommentLabelHeight) +
                             CGFloat(padding8) +
                             CGFloat(likeButtonHeight)

