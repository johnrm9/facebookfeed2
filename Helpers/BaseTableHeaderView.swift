//
//  BaseTableHeaderView.swift
//  facebookfeed2
//
//  Created by John Martin on 9/19/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

class BaseTableHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    func setupViews() {

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
