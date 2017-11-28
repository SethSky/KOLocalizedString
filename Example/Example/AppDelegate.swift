//
//  AppDelegate.swift
//  Example
//
//  Created by Oleksandr Khymych on 27.11.2017.
//  Copyright © 2017 Oleksandr Khymych. All rights reserved.
//

import UIKit
import KOLocalizedString

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // 1. is enabel debug
        KOLocalizedCore.main.isEnabelDebug = true
        // 2. is is update from server
        KOLocalizedCore.main.isUpdateOutside = true
        // 3. Set url api
        KOLocalizedCore.main.url = "http://khimich.com.ua/api"
        //if change build id to 2.0, will load v2.0 Localizable.plist from server
        debugPrint(KOGetLanguageArray())
        return true
    }
}

