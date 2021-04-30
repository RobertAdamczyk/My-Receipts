//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ReceiptsList: View {
    @StateObject var viewModel = ReceiptViewModel()
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [],
        animation: .default)
    private var receipts: FetchedResults<Receipts>
    
    var body: some View {
        List{
            ForEach(receipts, id: \.self) { receipt in
                ReceiptRow(receipt: receipt)
            }
            .onDelete(perform: removeReceipt)
            if receipts.isEmpty {
                HStack{
                    Spacer()
                    Text("You have no receipts.")
                    Spacer()
                }
                    
            }
            
            Button(action:{
                UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

                    for notification in notifications {
                        print(notification)
                    }
                }
            }){
                Text("Test")
            }
           
        }
        .environmentObject(viewModel)
        .listStyle(PlainListStyle())
        .navigationTitle("My Receipts")
        
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