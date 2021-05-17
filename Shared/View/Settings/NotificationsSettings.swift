//
//  NotificationsSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 28.04.21.
//

import SwiftUI

struct NotificationsSettings: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    @EnvironmentObject var coreData: CoreDataViewModel
    @AppStorage("daysNotification") var daysNotification = 7
    
    var body: some View {
        List{
            if !viewModel.notificationAllowed {
                Section(header: Text("Info")){
                    VStack(spacing: 10){
                        HStack{
                            Spacer()
                            Text("❗️❗️❗️")
                            Spacer()
                        }
                        Text("You haven't allowed this app to show notifications.")
                        
                        Text("You can enable this functionality in IPhone:")
                        Text("Settings → My Receipts → Notifications → Allow")
                    }.font(.footnote)
                }
            }
            
            Section(header: Text("Enable Notifications")){
                Toggle("Allow Notifications", isOn: $viewModel.notificationAllowedInApp)
            }
            
            Section(header: Text("Notification Options"), footer: Text("The alert will come \(daysNotification) days before the warranty expires.")){
                Picker("Notify me before", selection: $daysNotification) {
                    ForEach(0..<51) { i in
                        Text("\(i)")
                    }
                }
            }
        
            
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Notifications", displayMode: .inline)
        .onChange(of: daysNotification) { _ in
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            viewModel.checkNotifications(array: coreData.receipts)
        }
        .onChange(of: viewModel.notificationAllowedInApp) { _ in
            viewModel.checkNotifications(array: coreData.receipts)
        }
    }
}

struct NotificationsSettings_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSettings()
            .environmentObject(SettingsViewModel())
    }
}
