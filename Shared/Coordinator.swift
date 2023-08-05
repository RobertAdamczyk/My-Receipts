//
//  Coordinator.swift
//  Receipts Store
//
//  Created by Robert Adamczyk on 02.08.23.
//

import SwiftUI

final class Coordinator: ObservableObject {

    @Published var tabView: Views = .list

    func showTabView(_ tabView: Views) {
        self.tabView = tabView
    }
}
