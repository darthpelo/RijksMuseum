//
//  AppDelegate.swift
//  RijksMuseum
//
//  Created by Alessio Roberto on 11/05/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        Reachability.shared.startNetworkReachabilityObserver()

        let factory = CollectionFactory()
        let navigationController = UINavigationController()
        let collectionViewController = factory.create(withNavigationController: navigationController)
        navigationController.viewControllers = [collectionViewController]

        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        return true
    }
}
