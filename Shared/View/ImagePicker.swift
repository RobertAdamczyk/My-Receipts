//
//  ImagePicker.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 23.04.21.
//

import SwiftUI

struct ImagePickerView: View {

    let parentCoordinator: Receipts_Store.Coordinator
    let sourceType: UIImagePickerController.SourceType
    let completion: (UIImage) -> Void

    var body: some View {
        ImagePicker(parentCoordinator: parentCoordinator, sourceType: sourceType, completion: completion)
            .ignoresSafeArea()
    }
}

private struct ImagePicker: UIViewControllerRepresentable {

    let parentCoordinator: Receipts_Store.Coordinator
    let sourceType: UIImagePickerController.SourceType
    let completion: (UIImage) -> Void

    // MARK: - Coordinator Class
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.completion(uiImage)
            }

            parent.parentCoordinator.dismiss()
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = sourceType
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }
}
