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
                    Text(appText(.generic(.categories)))
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
                    Text(appText(.generic(.receipts)))
                        .apply(.regular, size: .S, color: .gray)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    VStack(spacing: 28){
                        ForEach(homeViewModel.receipts, id: \.self) { receipt in
                            HomeReceiptCell(receipt: receipt)
                        }
                    }
                    .padding()
                }
            }
            Spacer(minLength: 0)
        }
        .background(appColor(.background))
        .ignoresSafeArea(edges: .bottom)
        .onAppear(perform: homeViewModel.onViewAppear)
        .onDisappear(perform: homeViewModel.onViewDisappear)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                AppButton(.appImage(.arrowDown), action: homeViewModel.onSortByTapped)
            }
        }
        .environmentObject(homeViewModel)
    }
}
