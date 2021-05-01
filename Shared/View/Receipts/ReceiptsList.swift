//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ReceiptsList: View {
    @StateObject var viewModel = ReceiptViewModel()
    @EnvironmentObject var settingsViewModel: SettingsViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var receipts: FetchedResults<Receipts>
    
    var body: some View {
        List{
            ForEach(receipts, id: \.self) { receipt in
                ReceiptRow(receipt: receipt)
                    .onAppear(){
                        settingsViewModel.checkNotifications(array: receipts)
                    }
            }
            .onDelete(perform: removeReceipt)
            if receipts.isEmpty {
                HStack{
                    Spacer()
                    Text("You have no receipts.")
                    Spacer()
                }
                    
            }
            
           
        }
        .environmentObject(viewModel)
        .listStyle(PlainListStyle())
        .navigationTitle("My Receipts")
        .onAppear(){
            settingsViewModel.notificationRequest()
        }
        .onChange(of: settingsViewModel.notificationAllowed) { value in
            if value {
                settingsViewModel.checkNotifications(array: receipts)
            }
        }
        
    }
    
    func removeReceipt(at offsets: IndexSet) {
        for index in offsets {
            let receipt = receipts[index]
            viewContext.delete(receipt)
            if let id = receipt.id {
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id.uuidString])
            }
            
            viewModel.saveContext(viewContext: viewContext)
        }
    }
}

struct ReceiptsList_Previews: PreviewProvider {
    static var previews: some View {
        ReceiptsList()
    }
}
