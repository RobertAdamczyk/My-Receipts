//
//  NotificationsSettings.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 28.04.21.
//

import SwiftUI

struct NotificationsSettings: View {
    @EnvironmentObject var viewModel: SettingsViewModel
    var body: some View {
        Form{
            Section{
                if viewModel.notificationAllowed {
                    Text("Notifications sakdbaksjdajksdjashdkjahsjkdhaskjdhajshdkjahsdkjahsdkjahsjkdha")
                }else{
                    
                }
            }
            
        }
        .navigationBarTitle("Notifications", displayMode: .inline)
    }
}

struct NotificationsSettings_Previews: PreviewProvider {
    static var previews: some View {
        NotificationsSettings()
    }
}
