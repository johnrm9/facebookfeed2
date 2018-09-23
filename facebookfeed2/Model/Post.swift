//
//  Post.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

class Post: SafeJsonObject {
    @objc var name: String?
    @objc var profileImageName: String?
    @objc var statusText: String?
    @objc var statusImageName: String?
    @objc var numLikes: NSNumber?
    @objc var numComments: NSNumber?
    @objc var location: Location?
    @objc var statusImageUrl: String?

    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location"{
            location = Location()
            location?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class Location: NSObject {
    @objc var city: String?
    @objc var state: String?

    init(city: String? = nil, state: String? = nil) {
        self.city = city
        self.state = state
    }
}

class SafeJsonObject: NSObject {
    override func setValue(_ value: Any?, forKey key: String) {
        if responds(to: Selector("set\(key.uppercaseFirst):")) {
            super.setValue(value, forKey: key)
        }
    }
}
