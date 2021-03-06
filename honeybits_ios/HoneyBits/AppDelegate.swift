//
//  AppDelegate.swift
//  HoneyBits
//
//  Created by Juan Daniel Ozuna Espinal on 7/1/19.
//  Copyright © 2019 Juan Daniel Ozuna Espinal. All rights reserved.
//

import UIKit
import SVProgressHUD
import ChameleonFramework
import Firebase
import GoogleSignIn
import FBSDKCoreKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var accountService: IAccountService = AccountService()
    var mainNavController: MainNavigationController = {
       let controller = MainNavigationController()
        return controller
    }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        GIDSignIn.sharedInstance()?.clientID = FirebaseApp.app()?.options.clientID
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        progressHudSetup()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        window?.rootViewController = mainNavController
        
        if let user = accountService.loggedUser {
            if user.rol! == .Keeper {
                mainNavController.loadKeeperController()
            }
        }
        
        return true
    }   

    func hideProgressHudOnUserTap(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.tapToDismiss(notification:)), name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    }
    
    @objc func tapToDismiss(notification: Notification) {
        SVProgressHUD.dismiss()
    }
    
    func removeProgressHudObserver(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.SVProgressHUDDidReceiveTouchEvent, object: nil)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        removeProgressHudObserver()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        removeProgressHudObserver()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
        hideProgressHudOnUserTap()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        hideProgressHudOnUserTap()
        checkForInternetConnection()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        removeProgressHudObserver()
        
    }

    private func progressHudSetup() {
        let pallet = ColorPallete()
        SVProgressHUD.setDefaultStyle(.custom)
        SVProgressHUD.setDefaultMaskType(.custom)
        SVProgressHUD.setBackgroundColor(pallet.getColor("ProgressBackground")!)
        SVProgressHUD.setForegroundColor(pallet.getColor("Progress")!)
        SVProgressHUD.setBackgroundLayerColor(UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.5))
        hideProgressHudOnUserTap()
    }
    
    
    private func checkForInternetConnection() {
        //TODO: write code to check for internet connection
    }
}

