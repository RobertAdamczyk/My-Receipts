//
//  AppDelegate.swift
//  Receipts Store (iOS)
//
//  Created by Robert Adamczyk on 13.08.23.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        #if DEBUG
        printAppLanguages()
        #endif
        return true
    }
}

#if DEBUG
extension AppDelegate {

    private func printAppLanguages() {
        var availableLanguages = Bundle.main.localizations as [String]
        print("DEBUG INFO*  AvailableLanguages: \(availableLanguages)")
    }
}
#endif
