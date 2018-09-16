//
//  AppDelegate.swift
//  facebookfeed2
//
//  Created by John Martin on 9/15/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

struct Constants {
    static let barTintColor = "barTintColor"
    static let backgroundColor = "backgroundColor"
    static let infoLineColor = "infoLineColor"
    static let likesCommentColor = "likesCommentColor"
    static let dividerLineColor = "dividerLineColor"
    static let buttonTitleColor = "buttonTitleColor"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        window?.rootViewController = UINavigationController(rootViewController: feedController)
        window?.makeKeyAndVisible()

        UINavigationBar.appearance().barTintColor = UIColor(named: Constants.barTintColor) ?? .rgb(r: 51, g: 90, b: 149)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor : UIColor.white]
        application.statusBarStyle = .lightContent
        return true
    }
}

