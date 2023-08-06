//
//  Coordinator.swift
//  Receipts Store
//
//  Created by Robert Adamczyk on 02.08.23.
//

import SwiftUI

final class Coordinator: ObservableObject {

    @Published var stackedViews: [StackView] = []
    @Published var presentedFullCoverSheet: FullCoverSheet?
    @Published var presentedStandardSheet: StandardSheet?
    @Published var presentedDialogApp: DialogApp.Model?

    @Published private(set) var shouldShowMenu: Bool = false
    @Published private(set) var tabView: Views = .list

    private(set) var dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    func pushView(_ view: StackView) {
        stackedViews.append(view)
    }

    func presentFullCoverSheet(_ view: FullCoverSheet) {
        presentedFullCoverSheet = view
    }

    func presentStandardSheet(_ view: StandardSheet) {
        presentedStandardSheet = view
    }

    func presentDialogApp(_ model: DialogApp.Model) {
        presentedDialogApp = model
    }

    func dismiss() {
        presentedStandardSheet = nil
        presentedFullCoverSheet = nil
    }

    func showMenu() {
        shouldShowMenu = true
    }

    func hideMenu() {
        shouldShowMenu = false
    }

    func showTabView(_ tabView: Views) {
        self.tabView = tabView
    }
}
