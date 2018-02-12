//
//  AppDelegate.swift
//  Mine
//
//  Created by coolerting on 2018/2/9.
//  Copyright © 2018年 coolerting. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow.init(frame: UIScreen.main.bounds)
        let navi:UINavigationController = UINavigationController.init(rootViewController: RootViewController())
        navi.navigationBar.barTintColor = UIColor.CustomColor(Red: 0, Green: 191, Blue: 255, Alpha: 1)
        navi.navigationBar.isTranslucent = false
        navi.navigationBar.tintColor = UIColor.white
        navi.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navi.navigationBar.backIndicatorImage = UIImage.init(named: "ic-back-1")
        navi.navigationBar.backIndicatorTransitionMaskImage = UIImage.init(named: "ic-back-1")
        window?.rootViewController = navi
        
        let keyboardManager = IQKeyboardManager.shared()
        keyboardManager.isEnabled = true
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.shouldToolbarUsesTextFieldTintColor = true
        keyboardManager.toolbarManageBehaviour = .bySubviews
        keyboardManager.isEnableAutoToolbar = false
        keyboardManager.shouldShowToolbarPlaceholder = true
        keyboardManager.placeholderFont = UIFont.systemFont(ofSize: 17)
        keyboardManager.keyboardDistanceFromTextField = 10.0
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

