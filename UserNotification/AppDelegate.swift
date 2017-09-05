//
//  AppDelegate.swift
//  UserNotification
//
//  Created by Jörn Schoppe on 04.09.17.
//  Copyright © 2017 pixeldock. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        registerUserNotifications()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        scheduleLocalNotification()
    }
    
    func registerUserNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            guard granted else { return }
            self.setNotificationCategories()
        }
    }

    func setNotificationCategories() {
        // Create the custom actions
        let snoozeAction = UNNotificationAction(identifier: "SNOOZE_ACTION",
                                                title: "Snooze",
                                                options: .destructive)
        let confirmAction = UNNotificationAction(identifier: "CONFIRM_ACTION",
                                              title: "Confirm",
                                              options: [])
        
        let expiredCategory = UNNotificationCategory(identifier: "TIMER_EXPIRED",
                                                     actions: [snoozeAction, confirmAction],
                                                     intentIdentifiers: [],
                                                     options: UNNotificationCategoryOptions(rawValue: 0))
        
        // Register the category.
        let center = UNUserNotificationCenter.current()
        center.setNotificationCategories([expiredCategory])
    }
    
    func scheduleLocalNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Buy milk!"
        content.body = "Remember to buy milk from store!"
        content.categoryIdentifier = "TIMER_EXPIRED"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
        
        // Create the request object.
        let request = UNNotificationRequest(identifier: "Milk reminder", content: content, trigger: trigger)
        
        // Schedule the request.
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let theError = error {
                print(theError.localizedDescription)
            }
        }
    }
}

