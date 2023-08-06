//
//  Home.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct TabViews: View {
    @ObservedObject var coordinator: Coordinator

    init(coordinator: Coordinator) {
        self._coordinator = .init(wrappedValue: coordinator)
    }
    
    var body: some View {
        ZStack{
            switch coordinator.tabView {
            case .list: ReceiptsList(coordinator: coordinator)
            case .settings: Settings(coordinator: coordinator)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: coordinator.showMenu) {
                    Image(systemName: "line.horizontal.3")
                }
            }
        }
        .animation(.none, value: coordinator.tabView)
    }
}
