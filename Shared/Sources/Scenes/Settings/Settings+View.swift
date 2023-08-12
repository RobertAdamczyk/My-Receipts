//
//  Settings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct SettingsView: View {

    @StateObject var viewModel: SettingsViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        Form {
            Section(header: Text(appText(.settings(.generalSection)))) {
                ForEach(viewModel.generalDataSource) { source in
                    makeButton(text: source.text, action: source.action)
                }
            }
            
            Section(header: Text(appText(.settings(.appSection)))){
                ForEach(viewModel.appDataSource) { source in
                    makeButton(text: source.text, action: source.action)
                }
            }
        }
        .navigationTitle(appText(.settings(.title)))
    }

    private func makeButton(text: String, action: @escaping () -> Void) -> some View {
        AppButton(.form(.navigation(text, nil)), action: action)
    }
}
