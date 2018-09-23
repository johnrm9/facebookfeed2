//
//  DarkView.swift
//  facebookfeed2
//
//  Created by John Martin on 9/18/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

class DarkView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black; alpha = 0
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
