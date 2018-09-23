//
//  CustomTabBarController.swift
//  facebookfeed2
//
//  Created by John Martin on 9/16/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

extension UITabBar {
    static var topThinBorderLine: CALayer {
        let layer = CALayer()
        layer.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        layer.backgroundColor = UIColor.rgb(r: 229, g: 231, b: 235).cgColor
        return layer
    }
}
extension UITabBarController {
    func fixTabBar() {
        tabBar.isTranslucent = false
        tabBar.clipsToBounds = true
        tabBar.layer.addSublayer(UITabBar.topThinBorderLine)
    }
}

class CustomTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let feedNavigationController = templateNavigationController(title: "News Feed", unselectedImage: #imageLiteral(resourceName: "news_feed_icon"),
                                                                    rootViewController: FeedController(collectionViewLayout: UICollectionViewFlowLayout()))

        let friendsRequestNavigationController = templateNavigationController(title: "Requests", unselectedImage: #imageLiteral(resourceName: "requests_icon"), rootViewController: FriendRequestsController())
        let messengerNavigationController = templateNavigationController(title: "Messenger", unselectedImage: #imageLiteral(resourceName: "messenger_icon"))
        let notificatonsNavigationController = templateNavigationController(title: "Notifications", unselectedImage: #imageLiteral(resourceName: "globe_icon"))
        let moreNavigationController = templateNavigationController(title: "More", unselectedImage: #imageLiteral(resourceName: "more_icon"))

        viewControllers = [feedNavigationController, friendsRequestNavigationController, messengerNavigationController, notificatonsNavigationController,
                           moreNavigationController]

        fixTabBar()
    }

    fileprivate func templateNavigationController(title: String, unselectedImage: UIImage, selectedImage: UIImage? = nil, rootViewController: UIViewController? = nil) -> UINavigationController {
        let viewController = rootViewController ?? UIViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.title = title
        navigationController.navigationBar.barStyle = .black

        navigationController.tabBarItem.image = unselectedImage
        if let selectedImage = selectedImage {
            navigationController.tabBarItem.selectedImage = selectedImage
        }

        navigationController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: -4, right: 0)

        viewController.view.backgroundColor = .white

        if rootViewController == nil {
            viewController.navigationItem.title = title
        }

        return navigationController
    }
}
