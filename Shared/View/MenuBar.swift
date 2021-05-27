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
                    viewModel.changeView(newView: .list)
                    viewModel.offMenu()
                }){
                    HStack{
                        Image(systemName: "scroll.fill")
                            .foregroundColor(Color("Blue"))
                        Text("Receipts")
                            .foregroundColor(Color("Grey"))
                    }
                }
                
                Button(action:{
                    viewModel.changeView(newView: .add)
                    viewModel.offMenu()
                    viewModel.showActionSheet.toggle()
                }){
                    HStack{
                        Image(systemName: "plus.app.fill")
                            .foregroundColor(Color("Blue"))
                        Text("Add Receipt")
                            .foregroundColor(Color("Grey"))
                    }
                }
                Button(action:{
                    viewModel.changeView(newView: .settings)
                    viewModel.offMenu()
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
            .frame(width: viewModel.widthMenu)
            .background(Rectangle()
                            .fill(LinearGradient(
                                    gradient: Gradient(stops: [
                                .init(color: Color(#colorLiteral(red: 0.5843137502670288, green: 0.8823529481887817, blue: 0.8274509906768799, alpha: 1)), location: 0),
                                .init(color: Color(#colorLiteral(red: 0.9882352948188782, green: 0.8901960253715515, blue: 0.5411764979362488, alpha: 1)), location: 1)]),
                                    startPoint: UnitPoint(x: 0.5760869012534805, y: 0.4304187364119937),
                                    endPoint: UnitPoint(x: 1.5072464415835352, y: 0.03078817916915394))))
            .overlay(HStack{
                Spacer()
                Rectangle()
                    .frame(width: 1)
                    .foregroundColor(.black)
            })
            if viewModel.showMenuBar {
                Color.clear
                    .contentShape(Rectangle())
                    .onTapGesture {
                        if viewModel.showMenuBar {
                            viewModel.offMenu()
                        }
                    }
            }else {
                Color.clear
            }
            
        }
        .ignoresSafeArea()
    }
}

struct MenuBar_Previews: PreviewProvider {
    static var previews: some View {
        MenuBar()
            .preferredColorScheme(.light)
            .environmentObject(HomeViewModel())
    }
}
