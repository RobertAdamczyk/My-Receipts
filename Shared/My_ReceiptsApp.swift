//
//  My_ReceiptsApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

@main
struct My_ReceiptsApp: App {

    @StateObject private var coordinator: Coordinator = .init()

    var body: some Scene {
        WindowGroup {
            Home(coordinator: coordinator)
                .preferredColorScheme(.light)
        }
    }
}
