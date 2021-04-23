//
//  Home.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct Home: View {
    @ObservedObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                if viewModel.view == .list {
                    ReceiptsList()
                }
            }
            .navigationBarItems(leading:
                                    HStack{
                                        Button(action:{
                                            withAnimation{
                                                viewModel.showMenuBar.toggle()
                                            }
                                        }){
                                            Image(systemName: "line.horizontal.3")
                                                .font(.title2)
                                                .foregroundColor(Color("Blue"))
                                        }
                                        .disabled(viewModel.showMenuBar)
                                    }
            )
        }
        .offset(x: viewModel.showMenuBar ? 170 : 0)
        .overlay(
            ZStack{
                MenuBar()
                    .offset(x: viewModel.showMenuBar ? 0 : -170)
                    .environmentObject(viewModel)
            }
        )
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
