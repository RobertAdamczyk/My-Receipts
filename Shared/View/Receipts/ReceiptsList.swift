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
        VStack(spacing: 0){
            NavigationTopBar(title: "Home")
            ScrollView{
                VStack(spacing: 0){
                    Text("Your Categories")
                        .font(.custom("Roboto Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 28){
                            ForEach(coreData.categories, id: \.self) { categorie in
                                CategorieView(categorie: categorie, color: .red)
                            }
                        }
                        .padding()
                    }
                }
                
                VStack(spacing: 0){
                    Text("Your Receipts")
                        .font(.custom("Roboto Medium", size: 14))
                        .foregroundColor(Color(#colorLiteral(red: 0.44, green: 0.44, blue: 0.44, alpha: 1)))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    VStack(spacing: 28){
                        ForEach(coreData.filteredReceipts, id: \.self) { receipt in
                            ReceiptRow(receipt: receipt)
                                .onAppear(){
                                    settingsViewModel.checkNotifications(array: coreData.receipts)
                                }
                        }
                    }
                    .padding()
                }
            }
            
            
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
