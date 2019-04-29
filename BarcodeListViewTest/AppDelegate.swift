//
//  AppDelegate.swift
//  BarcodeListViewTest
//
//  Created by Henk van der Spek on 29/04/2019.
//  Copyright © 2019 Henk van der Spek. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let window = UIWindow()
    
    private lazy var rootViewController: UIViewController = {
        return UINavigationController(
            rootViewController: ViewController()
        )
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window.rootViewController = rootViewController
        window.makeKeyAndVisible()
        
        return true
    }
}
