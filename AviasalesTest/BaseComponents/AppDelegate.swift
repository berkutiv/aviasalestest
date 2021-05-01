//
//  AppDelegate.swift
//  AviasalesTest
//
//  Created by Ivan Berkut on 28.04.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let controller = DestinationSelectionAssembly().configureModule()
        let navController = UINavigationController(rootViewController: controller)
        window = UIWindow()
        self.window!.rootViewController = navController
        self.window!.makeKeyAndVisible()

        return true
    }

}

