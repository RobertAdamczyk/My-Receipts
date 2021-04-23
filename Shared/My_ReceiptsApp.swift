//
//  My_ReceiptsApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

@main
struct My_ReceiptsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
