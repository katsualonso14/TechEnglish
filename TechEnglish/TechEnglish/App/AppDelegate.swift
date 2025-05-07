//
//  AppDelegate.swift
//  TechEnglish
//
//  Created by KatsuyaTamai on 2025/02/25.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Request for App Notification
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .sound, .badge]){
                (granted, _) in
                if granted{
                    UNUserNotificationCenter.current().delegate = self
                } else {
                    print("通知が許可されていない")
                }
                
            }
        
        if let notification = launchOptions?[.remoteNotification] as? [String: AnyObject] {
            handleNotification(userInfo: notification)
        }
        
        //Firebase Setting
        FirebaseApp.configure()
        
        return true
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


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //通知受信時の処理
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
          // アプリ起動中でもアラートと音で通知
          completionHandler([.banner, .sound])
          
      }
    
    // アプリが起動中 or バックグラウンドのときに通知をタップした場合
     func userNotificationCenter(_ center: UNUserNotificationCenter,didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void
     ) {
         let userInfo = response.notification.request.content.userInfo
         handleNotification(userInfo: userInfo)
         completionHandler()
     }
    // 通知をタップした際の処理
    func handleNotification(userInfo: [AnyHashable: Any]) {
        guard let page = userInfo["page"] as? String else { return }
        // 通知をタップした時にフラグを設定
        UserDefaults.standard.set(true, forKey: "launchedFromNotification")
        
        DispatchQueue.main.async {
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = scene.windows.first,
               let tabBarController = window.rootViewController as? UITabBarController,
               let navController = tabBarController.selectedViewController as? UINavigationController {
                let checkNotifController = CheckNotifController()
                checkNotifController.navigateToPage(navController: navController, page: page)
            }
        }
    }
}

