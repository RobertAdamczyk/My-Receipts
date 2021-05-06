//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ReceiptsList: View {
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @EnvironmentObject var coreData: CoreDataViewModel
    
    var body: some View {
        List{
            ForEach(coreData.receipts, id: \.self) { receipt in
                ReceiptRow(receipt: receipt)
                    .onAppear(){
                        settingsViewModel.checkNotifications(array: coreData.receipts)
                    }
            }
            .onDelete(perform: coreData.removeReceipt)
            if coreData.receipts.isEmpty {
                HStack{
                    Spacer()
                    Text("You have no receipts.")
                    Spacer()
                }
                    
            }
            
           
        }
        .listStyle(PlainListStyle())
        .navigationTitle("My Receipts")
        .onAppear(){
            settingsViewModel.notificationRequest()
            coreData.fetchReceipts()
        }
        .onChange(of: settingsViewModel.notificationAllowed) { value in
            if value {
                settingsViewModel.checkNotifications(array: coreData.receipts)
            }
        }
        
    }
}

struct ReceiptsList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptsList()
    }
}
