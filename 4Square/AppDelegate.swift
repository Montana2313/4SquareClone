//
//  AppDelegate.swift
//  4Square
//
//  Created by Özgür  Elmaslı on 18.01.2018.
//  Copyright © 2018 Özgür  Elmaslı. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let config = ParseClientConfiguration { (ParseMutuableClientConfiguration) in
            
            ParseMutuableClientConfiguration.applicationId = "bc00f82736ca8979fd7980bd095af4df1c2d0db3"
            ParseMutuableClientConfiguration.clientKey = "26761eee95ac5b1b80ce8953d9c8c3c640a1c7b7"
            ParseMutuableClientConfiguration.server = "http://18.220.110.123:80/parse"
            
        }
        Parse.initialize(with: config)
        let defaultacl = PFACL()
        defaultacl.getPublicReadAccess = true
        defaultacl.getPublicWriteAccess = true
        PFACL.setDefault(defaultacl, withAccessForCurrentUser: true)
        rememberlogin()
        
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
    func rememberlogin()
    {
        let user : String? = UserDefaults.standard.string(forKey: "user")
        if user != nil
        {
            let board : UIStoryboard =  UIStoryboard(name: "Main", bundle: nil)
            let navigationcontroller = board.instantiateViewController(withIdentifier: "navigationVC") as! UINavigationController
            window?.rootViewController = navigationcontroller
        }
    }


}

