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
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    var body: some View {
//        List{
//
//            Section(header: Text("Receipts")) {
//                ForEach(coreData.filteredReceipts, id: \.self) { receipt in
//                    ReceiptRow(receipt: receipt)
//                        .onAppear(){
//                            settingsViewModel.checkNotifications(array: coreData.receipts)
//                        }
//                }
//                .onDelete(perform: coreData.removeReceipt)
//                if coreData.receipts.isEmpty {
//                    Text("You have no receipts.")
//                        .frame(maxWidth: .infinity)
//                }
//            }
//
//
//
//
//        }
//        .listStyle(GroupedListStyle())
        VStack{
            NavigationTopBar(title: "Home")
            Spacer()
        }
        .background(Color("NewBackground"))
        .ignoresSafeArea()
        .navigationBarHidden(true)
        .onAppear(){
            settingsViewModel.notificationRequest()
            coreData.fetchCategories()
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
