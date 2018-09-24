//
//  AppDelegate.swift
//  ResizinExample
//
//  Created by Jakub Olejník on 14/02/2018.
//  Copyright © 2018 Ackee. All rights reserved.
//

import UIKit
import Resizin

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    // MARK: UIApplication delegate
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupResizin()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: ViewController())
        window?.makeKeyAndVisible()
        return true
    }
    
    // MARK: Private helpers
    
    private func setupResizin() {
        let projectName = "ackee" // put your project name here
        let clientKey = "ackee_test_key" // put your client key here
        ResizinManager.setupSharedManager(projectName: projectName, clientKey: clientKey)
    }
}

