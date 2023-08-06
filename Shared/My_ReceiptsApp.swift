//
//  My_ReceiptsApp.swift
//  Shared
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

@main
struct My_ReceiptsApp: App {

    @StateObject private var coordinator: Coordinator

    init() {
        let notificationsRepository: NotificationsRepository = .init()
        let coreDataService: CoreDataService = .init()
        let dependencies: Dependencies = .init(notificationsRepository: notificationsRepository,
                                               coreDataService: coreDataService)
        self._coordinator = .init(wrappedValue: .init(dependencies: dependencies))
    }

    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.stackedViews) {
                TabViews(coordinator: coordinator)
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
            .offset(x: coordinator.shouldShowMenu ? MenuBar.widthMenu : 0)
            .overlay(MenuBar(coordinator: coordinator))
            .animation(.easeInOut, value: coordinator.shouldShowMenu)
            .tint(.black)
            .preferredColorScheme(.light)
        }
    }
}
