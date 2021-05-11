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
            if !coreData.categories.isEmpty {
                Section(header: Text("Categories")){
                    ForEach(coreData.categories, id: \.self) { categorie in
                        NavigationLink(destination: Text("123")) {
                            VStack{
                                Text(categorie.title ?? "")
                                    .font(.title3)
                                    .fontWeight(.semibold)
                            }
                            .padding(.vertical, 10)
                        }
                    }
                    
                }
            }
            
            Section(header: Text("Receipts")) {
                ForEach(coreData.receipts, id: \.self) { receipt in
                    ReceiptRow(receipt: receipt)
                        .onAppear(){
                            settingsViewModel.checkNotifications(array: coreData.receipts)
                        }
                }
                .onDelete(perform: coreData.removeReceipt)
                if coreData.receipts.isEmpty {
                    Text("You have no receipts.")
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            
           
        }
        .listStyle(GroupedListStyle())
        .navigationTitle("My Receipts")
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
