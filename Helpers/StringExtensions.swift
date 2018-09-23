//
//  StringExtensions.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import Foundation

extension String {
    var first: String {
        return String(self.prefix(1))
    }
    var last: String {
        return String(self.suffix(1))
    }
    var uppercaseFirst: String {
        return first.uppercased() + String(self.dropFirst())
    }
}

extension Int { var spaces: String {
    return String(repeating: " ", count: self) }
}
