//
//  ImagePreviewViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 08.05.21.
//

import SwiftUI

class ImagePreviewViewModel: NSObject, ObservableObject {
    @Published var offset = CGSize.zero
    @Published var showAlert = false
    @Published var saved = false
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image. \(error)")
            showAlert.toggle()
            return
        }
        
        saved = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.saved = false
        }
    }
}

