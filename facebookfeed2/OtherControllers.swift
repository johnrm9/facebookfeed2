//
//  OtherControllers.swift
//  facebookfeed2
//
//  Created by John Martin on 9/16/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

struct Friend {
    let name: String
    let image: UIImage
}

class FriendRequestsController: UITableViewController {

    private let cellId: String = "cellId"
    private let headerId: String = "headerId"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "Friend Requests"

        tableView.separatorColor = .separatorColor

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

        cell.imageView?.backgroundColor = .black

        cell.friend =
            indexPath.row % 3 == 0 ? Friend(name: "Mark Zuckerberg", image: #imageLiteral(resourceName: "zuckprofile")) :
            indexPath.row % 3 == 1 ? Friend(name: "Steve Jobs", image: #imageLiteral(resourceName: "steve_profile")) :
                                     Friend(name: "Mahatma Gandhi", image: #imageLiteral(resourceName: "gandhi_profile"))
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerId) as! RequestHeader

        header.headerText = section == 0 ? "FRIEND REQUESTS" : "PEOPLE YOU MAY KNOW"
        return header
    }

}

class RequestHeader: BaseTableHeaderView {

    var headerText: String! {
        didSet {
            nameLabel.text = headerText
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 10)
        label.textColor = UIColor(white: 0.4, alpha: 1)
        return label
    }()

    override func setupViews() {
        super.setupViews()

        let bottomBorderView = UIView.separatorView(UIColor.separatorColor)

        addSubviews(nameLabel, bottomBorderView)

        addConstraints(withVisualFormat: "H:|-8-[v0]-8-|", views: nameLabel)
        addConstraints(withVisualFormat: "V:|[v0][v1(0.5)]|", views: nameLabel, bottomBorderView)

        addConstraints(withVisualFormat: "H:|[v0]|", views: bottomBorderView)
    }
}

class FriendRequestCell: BaseTableCell {

    var friend: Friend! {
        didSet {
            nameLabel.text = friend.name
            requestImageView.image = friend.image
        }
    }

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 12)
        return label
    }()

    private let requestImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .blue
        imageView.layer.masksToBounds = true
        return imageView
    }()

    private let confirmButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .buttonBackgroundColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
        button.layer.cornerRadius = 2
        return button
    }()

    private let deleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Delete", for: .normal)
        button.setTitleColor(UIColor(white: 0.3, alpha: 1), for: .normal)
        button.layer.cornerRadius = 2
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        button.titleLabel?.font = .boldSystemFont(ofSize: 10)
        return button
    }()

    override func setupViews() {
        super.setupViews()

        addSubviews(requestImageView, nameLabel, confirmButton, deleteButton)

        addConstraints(withVisualFormat: "H:|-16-[v0(52)]-8-[v1]|", views: requestImageView, nameLabel)

        addConstraints(withVisualFormat: "V:|-4-[v0]-4-|", views: requestImageView)
        addConstraints(withVisualFormat: "V:|-8-[v0]-8-[v1(24)]-8-|", views: nameLabel, confirmButton)

        addConstraints(withVisualFormat: "H:|-76-[v0(80)]-8-[v1(80)]", views: confirmButton, deleteButton)

        addConstraints(withVisualFormat: "V:[v0(24)]-8-|", views: deleteButton)

    }
}

