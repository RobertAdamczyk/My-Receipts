//
//  ImagePreviewViewModel.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 08.05.21.
//

import SwiftUI

final class ImagePreviewViewModel: NSObject, ObservableObject {

    @Published var showAlert = false
    @Published var shouldShowSaveInPhotos = true
    @Published var shouldShowSaveCheckmark = false

    let uiImage: UIImage

    private let parentCoordinator: Coordinator

    init(uiImage: UIImage, parentCoordinator: Coordinator) {
        self.uiImage = uiImage
        self.parentCoordinator = parentCoordinator
    }

    func onSaveTapped() {
        writeToPhotoAlbum(uiImage: uiImage)
    }

    func onCloseTapped() {
        parentCoordinator.dismiss()
    }
    
    private func writeToPhotoAlbum(uiImage: UIImage) {
        UIImageWriteToSavedPhotosAlbum(uiImage, self, #selector(saveError), nil)
    }

    @objc private func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image. \(error)")
            showAlert.toggle()
            return
        }
        
        shouldShowSaveCheckmark = true
        shouldShowSaveInPhotos = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.shouldShowSaveCheckmark = false
        }
    }
}

