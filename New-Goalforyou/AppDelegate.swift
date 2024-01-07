//
//  AppDelegate.swift
//  New-Goalforyou
//
//  Created by KIM Hyung Jun on 1/3/24.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import RxKakaoSDKCommon
import RxKakaoSDKAuth
import KakaoSDKAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        RxKakaoSDK.initSDK(appKey: "dc1262f65f3da69f57acd9f22d4e56d4")
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        
        if handled {
            return true
        }
       
        if (AuthApi.isKakaoTalkLoginUrl(url)) {
           return AuthController.rx.handleOpenUrl(url: url)
        }
        
        return false
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {

    }


}

