//
//  Home.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct TabsView: View {
    @ObservedObject var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self._coordinator = .init(wrappedValue: coordinator)
    }
    
    var body: some View {
        ZStack{
            switch coordinator.tabView {
            case .list: HomeView(coordinator: coordinator)
            case .settings: SettingsView(coordinator: coordinator)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                AppButton(.appImage(.lineHorizontal), action: coordinator.showMenu)
            }
        }
        .animation(.none, value: coordinator.tabView)
    }
}
