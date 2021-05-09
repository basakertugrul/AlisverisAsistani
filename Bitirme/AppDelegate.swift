//
//  AppDelegate.swift
//  Bitirme
//
//  Created by Başak Ertuğrul on 16.04.2021.
//

import UIKit
import SwiftKeychainWrapper

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if KeychainWrapper.standard.string(forKey: "username") != nil {
            var dateExpiration: Date
            if KeychainWrapper.standard.string(forKey: "expiration") != nil {
                let formatter = Foundation.DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            }
        }
        
//        let removeSuccessfulToken: Bool = KeychainWrapper.standard.removeObject(forKey: "token")
//        let removeSuccessfulUsername: Bool = KeychainWrapper.standard.removeObject(forKey: "username")
//        let removeSuccessfulExpiration: Bool = KeychainWrapper.standard.removeObject(forKey: "expiration")
        
        return true
    }
}

// MARK: UISceneSession Lifecycle

func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}



