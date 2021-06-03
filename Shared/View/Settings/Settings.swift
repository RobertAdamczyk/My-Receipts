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
            Section(header: Text("General")){
                NavigationLink(destination: NotificationsSettings()
                                                .environmentObject(viewModel)) {
                    HStack(spacing: 15){
                        Image(systemName: "globe")
                            .foregroundColor(.white)
                            .font(.title3)
                            .padding(5)
                            .background(RoundedRectangle(cornerRadius: 5).foregroundColor(.red))
                        Text("Notifications")
                    }
                    
                }
                NavigationLink(destination: CategoriesSettings()
                                                .environmentObject(viewModel)) {
                    HStack(spacing: 15){
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
                NavigationLink(destination: AboutView()) {
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

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
            .preferredColorScheme(.dark)
    }
}
