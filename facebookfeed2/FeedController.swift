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

    func changeTabBarWithHidden(_ hidden: Bool, animated: Bool = true) {
        guard let tabBar = tabBarController?.tabBar else { return }
        let height = UIScreen.main.bounds.size.height
        let offset = hidden ? height : height - tabBar.frame.size.height
        tabBar.isTranslucent = !hidden
        guard offset != tabBar.frame.origin.y else { return }
        UIView.animate(withDuration: animated ? 0.5 : 0, animations: {
            tabBar.frame.origin.y = offset
        }, completion: { (_) in
            self.tabBarController?.fixTabBar()
        })
    }
}

class FeedController: UICollectionViewController {
    private let cellId: String = "cellId"

    let postData = PostData()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        imageCache.removeAllObjects()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .backgroundColor

        navigationItem.title = "FaceBook Feed"

        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)

        collectionView?.alwaysBounceVertical = true
    }

    private let keyWindow = UIApplication.shared.keyWindow ?? UIWindow()

    private lazy var darkNavBarView = DarkView(frame: CGRect(x: 0, y: 0, width: 1000, height: 20 + 44))

    private lazy var blackBackgroundView = DarkView(frame: self.view.frame)

    private lazy var darkTabBarView = DarkView(frame: CGRect(x: 0, y: self.keyWindow.frame.height - 49,
                                                             width: self.view.frame.width, height: 49))

    private lazy var zoomImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
        return imageView
    }()

    private var statusImageView: UIImageView? {
        willSet { statusImageView?.toggleAlpha() }
        didSet { statusImageView?.toggleAlpha() }
    }

    private func startingFrame(with view: UIView?) -> CGRect? {
        guard let startingFrame = view?.superview?.convert(view?.frame ?? .zero, to: nil) else { return nil }
        return startingFrame
    }

    func animateImageView(with imageView: UIImageView) {
        statusImageView = imageView
        guard let startingFrame = startingFrame(with: statusImageView) else { return }

        zoomImageView.frame = startingFrame
        zoomImageView.image = statusImageView?.image

        keyWindow.addSubviews(darkNavBarView, darkTabBarView)
        view.addSubviews(blackBackgroundView, zoomImageView)

        zoomIn(with: startingFrame)
    }

    private func zoomIn(with startingFrame: CGRect) {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.5, options: .curveEaseOut,
                       animations: { [unowned self] in
                        let width = self.view.frame.width
                        let height = width / startingFrame.width * startingFrame.height
                        let y = width / 2 - height / 2
                        //self.zoomImageView.frame = CGRect(origin: .zero, size: CGSize(width: width, height: height)).offSetByY(dy: y)
                        self.zoomImageView.frame = CGRect.shared.zeroOrigin(with: CGSize(width: width, height: height)).offSetByY(dy: y)
                        //self.zoomImageView.frame = CGRect(x: 0, y: y, width: width, height: height)
                        UIView.toggleAlphas(views: self.blackBackgroundView, self.darkNavBarView, self.darkTabBarView)
        })
    }

    @objc private func zoomOut() {
        guard let startingFrame = startingFrame(with: statusImageView) else { return }

        UIView.animate(withDuration: 0.75, animations: { [unowned self] in
            self.zoomImageView.frame = startingFrame
            UIView.toggleAlphas(views: self.blackBackgroundView, self.darkNavBarView, self.darkTabBarView)
        }) { [unowned self] (_) in
            self.zoomImageView.removeFromSuperview()
            self.blackBackgroundView.removeFromSuperview()
            self.darkNavBarView.removeFromSuperview()
            self.darkTabBarView.removeFromSuperview()

            self.statusImageView = nil
        }
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
}

extension FeedController: UICollectionViewDelegateFlowLayout {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return postData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = postData[indexPath.item]
        feedCell.feedController = self
        return feedCell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        let knownHeight: CGFloat = ServiceMetrics.shared.knownHeight

        if let statusText = postData[indexPath.item].statusText {
            let rect = CGRect.estimatedBoundingRectWithString(statusText, width: width, attributes: FeedCell.knownAttributes)
            return CGSize(width: width, height: rect.height + knownHeight + 36)
        }
        return CGSize(width: width, height: 500)
    }
}

protocol feedControllerDelegate: class {
    var feedController: FeedController? { get }
}

class FeedCell: BaseCell, feedControllerDelegate {
    weak var feedController: FeedController?

    @objc private func animate() {
        feedController?.animateImageView(with: statusImageView)
    }

    static let knownFont: UIFont = .preferredFont(forTextStyle: .body) // UIFont.systemFont(ofSize: 14)
    static let knownAttributes: [NSAttributedString.Key: Any] = [.font: knownFont]

    var post: Post? {
        didSet {
            guard let post = post else { return }
            guard let name = post.name else { return }

            if let statusImageUrl = post.statusImageUrl {
                statusImageView.loadImageUsingUrlString(statusImageUrl)
            } else if let statusImageName = post.statusImageName {
                statusImageView.image = UIImage(named: statusImageName)
            }

            let cityName = post.location?.city ?? "Nowhere City"
            let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
            let bullet = "•"
            let string = "\n" + "December 18\(2.spaces + bullet + 2.spaces)" + "\(cityName)\(2.spaces + bullet + 2.spaces)"

            attributedText.append(NSAttributedString(string: string,
                                attributes: [.font: UIFont.systemFont(ofSize: 12),
                                             .foregroundColor: UIColor.infoLineColor]))
            let bounds = CGRect.shared.smallImageFrame.offSetByY(dy: -2)
            nameLabel.attributedText = attributedText
                                        .setLineSpacing(4)
                                        .attachImage( #imageLiteral(resourceName: "globe_small.png")/* globe_small */, bounds: bounds)

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

    private let nameLabel: UILabel = {
        let label = UILabel()
        //label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 2
        return label
    }()

    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 44 / 2
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = FeedCell.knownFont
        textView.isScrollEnabled = false
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()

    private lazy var statusImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        return imageView
    }()

    private let likesCommentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .likesCommentColor
        return label
    }()

    private let likeButton: UIButton = UIButton.buttonForTitle("Like", image: #imageLiteral(resourceName: "like"))
    private let commentButton: UIButton = UIButton.buttonForTitle("Comment", image: #imageLiteral(resourceName: "comment"))
    private let shareButton: UIButton = UIButton.buttonForTitle("Share", image: #imageLiteral(resourceName: "share"))

    override func setupViews() {
        super.setupViews()

        let metrics = ServiceMetrics.shared.metrics

        backgroundColor = .white

        let dividerLineView = UIView.separatorView(.dividerLineColor)

        addSubviews(nameLabel, profileImageView, statusTextView, statusImageView, likesCommentLabel, dividerLineView,
                    likeButton, commentButton, shareButton)

        addConstraints(withVisualFormat: "H:|-8-[v0(ih0)]-8-[v1]|",
                       metrics: metrics,
                       views: profileImageView, nameLabel)
        addConstraints(withVisualFormat: "H:|-4-[v0]-4-|", views: statusTextView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: statusImageView)
        addConstraints(withVisualFormat: "H:|-12-[v0]|", views: likesCommentLabel)
        addConstraints(withVisualFormat: "H:|-12-[v0]-12-|", views: dividerLineView)

        addConstraints(withVisualFormat: "H:|[v0(v2)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)

        addConstraints(withVisualFormat: "V:|-12-[v0]", views: nameLabel)

        addConstraints(withVisualFormat: "V:|-p0-[v0(ih0)]-p1-[v1]-p1-[v2(ih1)]-p0-[v3(lh0)]-p0-[v4(0.4)][v5(bh0)]|",
                       metrics: metrics,
                       views: profileImageView,
                       statusTextView,
                       statusImageView,
                       likesCommentLabel,
                       dividerLineView,
                       likeButton)

        addConstraints(withVisualFormat: "V:[v0(bh0)]|",
                       metrics: metrics,
                       views: commentButton)
        addConstraints(withVisualFormat: "V:[v0(bh0)]|",
                       metrics: metrics,
                       views: shareButton)

    }
}
