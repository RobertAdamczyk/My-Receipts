//
//  HomeViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    @Published var view: Views = .list
    @Published var showMenuBar = false
    @Published var showingMenu = false
    @Published var widthMenu: CGFloat = 180
    @Published var showActionSheet = false
    
    @Published var selectedImage: UIImage?
    
    @Published var showImagePicker = false
    @Published var showCamera = false
    
    func requestNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("All set!")
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
