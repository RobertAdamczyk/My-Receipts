//
//  ReceiptsList.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct HomeView: View {

    @StateObject var homeViewModel: HomeViewModel

    init(coordinator: Coordinator) {
        self._homeViewModel = .init(wrappedValue: .init(coordinator: coordinator))
    }
    
    var body: some View {
        VStack(spacing: 0){
            ScrollView(showsIndicators: false){
                VStack(spacing: 0){
                    Text("Your Categories")
                        .apply(.regular, size: .S, color: .gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.top, 20)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 28){
                            HomeCategorieCell(count: homeViewModel.allReceiptsCount)
                                .onTapGesture {
                                    homeViewModel.onCategorieTapped(categorie: nil)
                                }
                            ForEach(homeViewModel.categories, id: \.self) { categorie in
                                HomeCategorieCell(categorie: categorie)
                                    .onTapGesture {
                                        homeViewModel.onCategorieTapped(categorie: categorie)
                                    }
                            }
                        }
                        .padding()
                    }
                }
                
                VStack(spacing: 0){
                    Text("Your Receipts")
                        .apply(.regular, size: .S, color: .gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    VStack(spacing: 28){
                        ForEach(homeViewModel.receipts, id: \.self) { receipt in
                            HomeReceiptCell(receipt: receipt)
                                .onAppear(){
                                    //settingsViewModel.checkNotifications(array: coreData.receipts)
                                }
                        }
                    }
                    .padding()
                }
            }
            Spacer(minLength: 0)
        }
        .background(Color("background"))
        .ignoresSafeArea(edges: .bottom)
        .onAppear(perform: homeViewModel.onViewAppear)
        .onDisappear(perform: homeViewModel.onViewDisappear)
        //{
            // settingsViewModel.notificationRequest() // TODO: X
            //coreData.fetchCategories()
            //coreData.fetchReceipts()
        //}
//        .onChange(of: settingsViewModel.notificationAllowed) { value in //
//            if value {
//                settingsViewModel.checkNotifications(array: coreData.receipts)
//            }
//        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: homeViewModel.onSortByTapped) {
                    Image(systemName: "arrow.down")
                }
            }
        }
        .environmentObject(homeViewModel)
    }
}
