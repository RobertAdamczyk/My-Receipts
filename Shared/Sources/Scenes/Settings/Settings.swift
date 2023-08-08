//
//  Settings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct Settings: View {

    @StateObject var viewModel: SettingsViewModel

    init(coordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        Form {
            Section(header: Text("General")) {
                Button(action: viewModel.onNotificationsSettingsTapped) {
                    HStack(spacing: 16){
                        Image(systemName: "globe")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.red))
                        Text("Notifications")
                    }
                }
                Button(action: viewModel.onCategoriesSettingsTapped) {
                    HStack(spacing: 16) {
                        Image(systemName: "text.book.closed.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(5)
                            .padding(.horizontal, 1)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.green))
                        Text("Categories")
                    }
                }
                
            }
            
            Section(header: Text("App")){
                Button(action: viewModel.onAboutTapped) {
                    HStack(spacing: 15){
                        Image(systemName: "info.circle.fill")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.blue))
                        Text("About")
                    }
                }
            }
        }
        .navigationTitle("Settings")
    }
}
