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
            Section(header: Text("General")) {
                ForEach(viewModel.generalDataSource) { source in
                    makeButton(text: source.text, action: source.action)
                }
            }
            
            Section(header: Text("App")){
                ForEach(viewModel.appDataSource) { source in
                    makeButton(text: source.text, action: source.action)
                }
            }
        }
        .navigationTitle("Settings")
    }

    private func makeButton(text: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Text(text)
                Spacer()
                Image(systemName: "chevron.right")
            }
            .apply(.regular, size: .M, color: .gray)
        }
    }
}
