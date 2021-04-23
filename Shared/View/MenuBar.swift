//
//  MenuBar.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct MenuBar: View {
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        HStack{
            VStack(alignment: .leading ,spacing: 40){
                Button(action:{
                    
                }){
                    HStack{
                        Image(systemName: "scroll.fill")
                            .foregroundColor(Color("Blue"))
                        Text("Receipts")
                            .foregroundColor(Color("Grey"))
                    }
                }
                
                Button(action:{
                    
                }){
                    HStack{
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color("Blue"))
                        Text("Add Receipt")
                            .foregroundColor(Color("Grey"))
                    }
                }
                Button(action:{
                    
                }){
                    HStack{
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color("Blue"))
                        Text("Settings")
                            .foregroundColor(Color("Grey"))
                    }
                }
                Spacer()
            }
            .font(.title3)
            .padding(.top, 100)
            .padding(.horizontal)
            .background(Color("Light"))
            .overlay(HStack{
                Spacer()
                Rectangle()
                    .frame(width: 2)
                    .foregroundColor(Color("Blue"))
            })
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    if viewModel.showingMenu {
                        withAnimation{
                            viewModel.showMenuBar = false
                        }
                    }
                }
        }
        .ignoresSafeArea()
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
            .preferredColorScheme(.light)
    }
}
