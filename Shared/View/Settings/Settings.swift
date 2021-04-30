//
//  Settings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct Settings: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    
    var body: some View {
        Form{
            Section{
                NavigationLink(destination: NotificationsSettings()) {
                    HStack(spacing: 15){
                        Image(systemName: "globe")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.red))
                        Text("Notification")
                    }
                    
                }
            }
        }
        .navigationTitle("Settings")
        .environmentObject(viewModel)
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .preferredColorScheme(.dark)
    }
}
