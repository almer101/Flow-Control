//
//  AppDelegate.swift
//  OnboardingPrototype
//
//  Created by Ivan Almer on 11/01/2019.
//  Copyright © 2019 AG04. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: ApplicationWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = ApplicationWindow()
        window?.makeKeyAndVisible()
        
        return true
    }

}

