//
//  AppDelegate.swift
//  facebookfeed2
//
//  Created by John Martin on 9/15/18.
//  Copyright © 2018 John Martin. All rights reserved.
//

import UIKit

struct Constants {
    static let facebookBlue = "facebookBlue"
    static let backgroundColor = "backgroundColor"
    static let infoLineColor = "infoLineColor"
    static let likesCommentColor = "likesCommentColor"
    static let dividerLineColor = "dividerLineColor"
    static let buttonTitleColor = "buttonTitleColor"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()

        window?.rootViewController = CustomTabBarController()

        UITabBar.appearance().tintColor = .tabBarTintColor

        UINavigationBar.appearance().barTintColor = .facebookBlue
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
        //application.statusBarStyle = .lightContent
        //UIApplication.shared.statusBarStyle = .lightContent
        return true
    }
}

