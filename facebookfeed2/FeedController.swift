//
//  FeedController.swift
//  facebookfeed2
//
//  Created by John Martin on 9/15/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UIViewController: UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let hidden: Bool = scrollView.panGestureRecognizer.translation(in: scrollView).y < 0
        changeTabBarWithHidden(hidden)
    }

    func changeTabBarWithHidden(_ hidden:Bool, animated: Bool = true) {
        guard let tabBar = tabBarController?.tabBar else { return }
        let height = UIScreen.main.bounds.size.height
        let offset = hidden ? height : height - tabBar.frame.size.height
        tabBar.isTranslucent = !hidden
        guard offset != tabBar.frame.origin.y else { return }
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            tabBar.frame.origin.y = offset
        }, completion: { (success) in
            self.tabBarController?.fixTabBar()
        })
    }
}

class Post {
    @objc var name: String?
    @objc var profileImageName: String?
    @objc var statusText: String?
    @objc var statusImageName: String?
    @objc var numLikes: NSNumber?
    @objc var numComments: NSNumber?
    var location: Location?
    var statuImageUrl: String?
}

class Location: NSObject {
    @objc var city: String?
    @objc var state: String?
    init(city: String?, state: String? = nil) {
        self.city = city
        self.state = state
    }
}

class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    let cellId: String = "cellId"
    private let backgroundColor: String = Constants.backgroundColor

    var posts = [Post]()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
        print("Empty imageCache - count = \(imageCache.countLimit)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText = "Meanwhile, Beast turned to the dark side."
        postMark.profileImageName = "zuckprofile"
        postMark.statusImageName = "zuckdog"
        postMark.numLikes = 400
        postMark.numComments = 123
        postMark.location = Location(city: "Bumfuk Egypt" )
        postMark.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"

        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = """
        Design is not just what it looks like and feels like. Design is how it works.

        Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying we've done something wonderful, that's what matters to me.

        Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and get on with improving your other innovations.
        """
        postSteve.profileImageName = "steve_profile"
        postSteve.statusImageName = "steve_status"
        postSteve.numLikes = 1000
        postSteve.numComments = 5500
        postSteve.location = Location(city: "Cupertino")
        postSteve.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"

        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n" +
            "The weak can never forgive. Forgiveness is the attribute of the strong.\n" +
        "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.profileImageName = "gandhi_profile"
        postGandhi.statusImageName = "gandhi_status"
        postGandhi.numLikes = 333
        postGandhi.numComments = 10.7 * 1000 as NSNumber
        postGandhi.location = Location(city: "Calcutta")
        postGandhi.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"

        let postTim = Post()
        postTim.name = "Tim Cook"
        postTim.statusText = """
                             The worst thing in the world that can happen to you if
                             you're an engineer that has given his life to something
                             is for someone to rip it off and put their name on it.
                            """
        postTim.profileImageName = "tim_profile"
        //postTim.statusImageName = "tim_status"
        postTim.numLikes = 528
        postTim.numComments =  12.8 * 1000 as NSNumber
        postTim.location = Location(city: "Cupertino")
        postTim.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/tim_cook_status.jpg"

        let postDon = Post()
        postDon.name = "Donald J. Trump"
        postDon.profileImageName = "don_profile"
        postDon.statusText = "An ’extremely credible source’ has called my office and told me that Barack Obama’s birth certificate is a fraud."
        postDon.statusImageName = nil
        postDon.numLikes = 666
        postDon.numComments = 13.99 * 1000 as NSNumber
        postDon.location = Location(city: "Washington, DC")
        postDon.statuImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/donald_trump_status.jpg"

        posts += [postMark]
        posts += [postSteve]
        posts += [postGandhi]
        posts += [postTim]
        posts += [postDon]

        collectionView?.backgroundColor = UIColor(named: backgroundColor) ?? UIColor(white: 0.95, alpha: 1)

        navigationItem.title = "FaceBook Feed"
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.alwaysBounceVertical = true
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.item]

        return feedCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let knownHeight: CGFloat = FeedCell.knownHeight
        let knownFont: UIFont = FeedCell.knownFont

        if let statusText = posts[indexPath.item].statusText {
            let rect = CGRect.estimatedBoundingRectWithString(statusText, width: width, attributes: [.font: knownFont])
            return CGSize(width: width, height: rect.height + knownHeight + 36)
        }
        return CGSize(width: width, height: 500)
    }
}
extension FeedController {

}
//var imageCache = NSCache<AnyObject, AnyObject>()

class FeedCell: BaseCell {
    static let knownHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
    static let knownFont: UIFont = UIFont.systemFont(ofSize: 14)

    var post: Post? {
        didSet {
            guard let post = post else { return }
            guard let name = post.name else { return }

            if let statusImageUrl = post.statuImageUrl {
                statusImageView.loadImageUsingUrlString(statusImageUrl)
            } else if let statusImageName = post.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }

            let cityName = post.location?.city ?? "Nowhere City"
            let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            let bullet = "•"
            let string = "\n" + "December 18\(2.spaces + bullet + 2.spaces)" + "\(cityName)\(2.spaces + bullet + 2.spaces)"

            let infolineColor = UIColor(named: Constants.infoLineColor) ?? .rgb(r: 155, g: 161, b: 171)
            attributedText.append(NSAttributedString(string: string, attributes: [.font: UIFont.systemFont(ofSize: 12), .foregroundColor: infolineColor]))
            nameLabel.attributedText = attributedText.setLineSpacing(4).attachImage(#imageLiteral(resourceName: "globe_small") /* globe_small */, bounds: CGRect(x: 0, y: -2, width: 12, height: 12))

            if let statusText = post.statusText {
                statusTextView.text = statusText
            }
            if let profileImageName = post.profileImageName {
                profileImageView.image = UIImage(named: profileImageName)
            }
            let likes = post.numLikes ?? 0
            let comments = post.numComments ?? 0
            let commentsK: String = Int(truncating: comments) < 1000 ? "\(comments)" : "\(Double(truncating: comments)/1000)K"
            likesCommentLabel.text =  "\(likes) Likes  \(commentsK) Comments"

        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 44 / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = FeedCell.knownFont
        textView.isScrollEnabled = false
        textView.isEditable = false
        return textView
    }()

    let statusImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        return imageView
    }()

    let likesCommentLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes  10.7K Comments"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(named: Constants.likesCommentColor) ?? .rgb(r: 155, g: 161, b: 171)
        return label
    }()

    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: Constants.dividerLineColor) ?? .rgb(r: 226, g: 228, b: 232)
        return view
    }()

    let likeButton: UIButton = FeedCell.buttonForTitle("Like", image: #imageLiteral(resourceName: "like"))
    let commentButton: UIButton = FeedCell.buttonForTitle("Comment", image: #imageLiteral(resourceName: "comment"))
    let shareButton: UIButton = FeedCell.buttonForTitle("Share", image: #imageLiteral(resourceName: "share"))

    static func buttonForTitle(_ title: String, image: UIImage) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        let buttonTitleColor = UIColor(named: Constants.buttonTitleColor) ?? .rgb(r: 143, g: 150, b: 163)
        button.setTitleColor(buttonTitleColor, for: .normal)
        button.setImage(image, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        return button
    }

    override func setupViews() {
        backgroundColor = .white

        addSubviews(nameLabel, profileImageView, statusTextView, statusImageView, likesCommentLabel, dividerLineView, likeButton, commentButton, shareButton)

        addConstraints(withVisualFormat: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraints(withVisualFormat: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: statusImageView)
        addConstraints(withVisualFormat: "H:|-12-[v0]|", views: likesCommentLabel)
        addConstraints(withVisualFormat: "H:|-12-[v0]-12-|", views: dividerLineView)

        addConstraints(withVisualFormat: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)

        addConstraints(withVisualFormat: "V:|-12-[v0]", views: nameLabel)

        addConstraints(withVisualFormat: "V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|",
                       views: profileImageView,
                       statusTextView,
                       statusImageView,
                       likesCommentLabel,
                       dividerLineView,
                       likeButton)

        addConstraints(withVisualFormat: "V:[v0(44)]|", views: commentButton)
        addConstraints(withVisualFormat: "V:[v0(44)]|", views: shareButton)

    }
}
