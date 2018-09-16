//
//  OtherControllers.swift
//  facebookfeed2
//
//  Created by John Martin on 9/16/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

class FriendRequestsController: UITableViewController {

    let cellId: String = "cellId"
    let headerId: String = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Friend Requests"

        tableView.separatorColor = .rgb(r: 229, g: 231, b: 235)
        tableView.sectionHeaderHeight = 26

        tableView.register(FriendRequestCell.self, forCellReuseIdentifier: cellId)
        tableView.register(RequestHeader.self, forHeaderFooterViewReuseIdentifier: headerId)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! FriendRequestCell

        if indexPath.row % 3 == 0 {
            cell.nameLabel.text = "Mark Zuckerberg"
            cell.requestImageView.image = #imageLiteral(resourceName: "zuckprofile")
        } else if indexPath.row % 3 == 1 {
            cell.nameLabel.text = "Steve Jobs"
            cell.requestImageView.image = #imageLiteral(resourceName: "steve_profile")
        } else {
            cell.nameLabel.text = "Mahatma Gandhi"
            cell.requestImageView.image = #imageLiteral(resourceName: "gandhi_profile")
        }

        cell.imageView?.backgroundColor = .black

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! RequestHeader

//        if section == 0 {
//            header.nameLabel.text = "FRIEND REQUESTS"
//        } else {
//            header.nameLabel.text = "PEOPLE YOU MAY KNOW"
//        }
        header.nameLabel.text = section == 0 ? "FRIEND REQUESTS" : "PEOPLE YOU MAY KNOW"
        return header
    }

}

class RequestHeader: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "FRIEND REQUESTS"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        return label
    }()

    let bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = .rgb(r: 229, g: 231, b: 235)
        return view
    }()

    func setupViews() {
        addSubviews(nameLabel, bottomBorderView)

        addConstraints(withVisualFormat: "H:|-8-[v0]-8-|", views: nameLabel)
        addConstraints(withVisualFormat: "V:|[v0][v1(0.5)]|", views: nameLabel, bottomBorderView)

        addConstraints(withVisualFormat: "H:|[v0]|", views: bottomBorderView)
    }
}

class FriendRequestCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sample Name"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        return label
    }()

    let requestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = UIColor.blue
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .rgb(r: 87, g: 143, b: 255)
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
        button.layer.cornerRadius = 2
        return button
    }()

    let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(white: 0.3, alpha: 1), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
        return button
    }()

    func setupViews() {
        addSubviews(requestImageView, nameLabel, confirmButton, deleteButton)

        addConstraints(withVisualFormat: "H:|-16-[v0(52)]-8-[v1]|", views: requestImageView, nameLabel)

        addConstraints(withVisualFormat: "V:|-4-[v0]-4-|", views: requestImageView)
        addConstraints(withVisualFormat: "V:|-8-[v0]-8-[v1(24)]-8-|", views: nameLabel, confirmButton)

        addConstraints(withVisualFormat: "H:|-76-[v0(80)]-8-[v1(80)]", views: confirmButton, deleteButton)

        addConstraints(withVisualFormat: "V:[v0(24)]-8-|", views: deleteButton)

    }

}

