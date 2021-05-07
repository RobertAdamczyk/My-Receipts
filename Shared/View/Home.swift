//
//  Home.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct Home: View {
    @StateObject var viewModel = HomeViewModel()
    @StateObject var settingsViewModel = SettingsViewModel()
    @StateObject var coreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        NavigationView {
            ZStack{
                if viewModel.view == .list {
                    ReceiptsList()
                }else if viewModel.view == .settings {
                    Settings()
                }else if viewModel.view == .add {
                    AddReceipt(showPicker: $viewModel.showImagePicker, takedPhotoData: $viewModel.takedPhotoData)
                }
                
            }
            .environmentObject(viewModel)
            .environmentObject(settingsViewModel)
            .environmentObject(coreDataViewModel)
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
        .accentColor(Color("Blue"))
        .offset(x: viewModel.showMenuBar ? viewModel.widthMenu : 0)
        .overlay(
            ImagePreview(selectedImage: $viewModel.selectedImage)
        )
        .overlay(
            MenuBar()
                .offset(x: viewModel.showMenuBar ? 0 : -viewModel.widthMenu)
                .environmentObject(viewModel)
        )
        .overlay(
            ZStack{
                if viewModel.showCamera {
                    CameraFullView(showCamera: $viewModel.showCamera)
                        .environmentObject(viewModel)
                }
            }
        )
        .onChange(of: viewModel.showMenuBar) { new in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                withAnimation{
                    viewModel.showingMenu = new
                }
            }
        }
        .actionSheet(isPresented: $viewModel.showActionSheet) {
            ActionSheet(title: Text("New Receipt"), buttons: [
                .default(Text("Take a photo")) {
                    viewModel.showImagePicker = false
                    viewModel.showCamera = true
                },
                .default(Text("Use existing")) {
                    viewModel.showImagePicker = true
                    viewModel.showCamera = false
                },
                .cancel()
            ])
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
