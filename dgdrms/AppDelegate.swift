//
//  AppDelegate.swift
//  dgdrms
//
//  Created by 08APO0516 on 18/06/2018.
//  Copyright © 2018 jca. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        StartUpAppSequencer.shared.start()
        return true
    }
}
