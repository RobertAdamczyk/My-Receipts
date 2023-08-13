//
//  My_ReceiptsApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

@main
struct My_ReceiptsApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var coordinator: Coordinator

    init() {
        let notificationsRepository: NotificationsRepository = .init()
        let coreDataService: CoreDataService = .init()
        let skStoreReviewRepository: SKStoreReviewRepository = .init()
        let dependencies: Dependencies = .init(notificationsRepository: notificationsRepository,
                                               coreDataService: coreDataService,
                                               skStoreReviewRepository: skStoreReviewRepository)
        self._coordinator = .init(wrappedValue: .init(dependencies: dependencies))
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.stackedViews) {
                TabsView(coordinator: coordinator)
                    .navigationDestination(for: StackView.self) {
                        DestinationView(stackView: $0, coordinator: coordinator)
                    }
            }
            .sheet(item: $coordinator.presentedStandardSheet) {
                StandardSheetView(standardSheet: $0, parentCoordinator: coordinator)
            }
            .fullScreenCover(item: $coordinator.presentedFullCoverSheet) {
                FullCoverSheetView(fullCoverSheet: $0, parentCoordinator: coordinator)
            }
            .dialogApp(item: $coordinator.presentedDialogApp)
            .overlay(MenuView(coordinator: coordinator))
            .offset(x: coordinator.shouldShowMenu ? MenuView.widthMenu : 0)
            .animation(.easeInOut, value: coordinator.shouldShowMenu)
            .tint(appColor(.gray))
            .preferredColorScheme(.light)
        }
    }
}
