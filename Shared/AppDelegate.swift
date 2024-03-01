//
//  AppDelegate.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 13.08.23.
//

import UIKit
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
