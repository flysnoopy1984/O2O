//
//  AppDelegate.swift
//  O2ODemo
//
//  Created by jackyPC on 2018/5/23.
//  Copyright © 2018年 jackyPC. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    let notificationHandler = NotificationCenter()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Thread.sleep(forTimeInterval: 10.0)
        
        
        /* 修改底部tab bar 样式*/
        UITabBar.appearance().tintColor = UIColor(red: 235.0/255.0, green: 75.0/255.0, blue: 27.0/255.0, alpha: 1.0)
        UITabBar.appearance().barTintColor = UIColor(red: 236/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
       // UITabBar.appearance().selectionIndicatorImage = UIImage(named: "tabitem-selected");
        
        //请求通知权限
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]){
            (accepted, error) in
                if !accepted {
                    //用户不允许消息通知
                }
            
        }
        //向APNs请求token
        UIApplication.shared.registerForRemoteNotifications();
    
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        // 将客户端DeviceToken和用户手机号传给服务端
       //  print("Get Push token: \(deviceToken.hexString)")
            UserData.PostDeviceToken(deviceToken:deviceToken.hexString);
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
      
        
        var msg = userInfo[AnyHashable("aps")] as! [String:Any];
        
        var json  = JSON(msg);
        var alert = json["alert"].string
          print("alert消息：\(alert)")
         print("收到新消息Active\(json)")
        if application.applicationState == UIApplication.State.active {
            // 代表从前台接受消息app
        }else{
            // 代表从后台接受消息后进入app
            UIApplication.shared.applicationIconBadgeNumber = 0
        }
        completionHandler(.newData)
        
       
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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "OOData")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
//对Data类型进行扩展
extension Data {
    //将Data转换为String
    var hexString: String {
        return withUnsafeBytes {(bytes: UnsafePointer<UInt8>) -> String in
            let buffer = UnsafeBufferPointer(start: bytes, count: count)
            return buffer.map {String(format: "%02hhx", $0)}.reduce("", { $0 + $1 })
        }
    }
}

