//
//  ImagePreview.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.04.21.
//

import SwiftUI

struct ImagePreviewView: View {

    @StateObject var viewModel: ImagePreviewViewModel

    init(uiImage: UIImage, parentCoordinator: Coordinator) {
        self._viewModel = .init(wrappedValue: .init(uiImage: uiImage,
                                                    parentCoordinator: parentCoordinator))
    }
    
    var body: some View {
        ZStack{
            Color.clear
            Image(uiImage: viewModel.uiImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .overlay {
            VStack(spacing: 20) {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 80, height: 80)
                Text("Saved")
            }
            .apply(.medium, size: .L, color: .hellBlue)
            .frame(width: 170, height: 170)
            .background {
                appColor(.black).opacity(0.7).cornerRadius(16)
            }
            .opacity(viewModel.shouldShowSaveCheckmark ? 1 : 0)
            .animation(.default, value: viewModel.shouldShowSaveCheckmark)
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: viewModel.onSaveTapped) {
                    Text("Save in Photos")
                        .apply(.medium, size: .M, color: .gray)
                }
                .opacity(viewModel.shouldShowSaveInPhotos ? 1 : 0)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: viewModel.onCloseTapped) {
                    Image(systemName: "xmark")
                        .apply(.medium, size: .M, color: .gray)
                }
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("You haven't allowed this app to save photos."),
                  message: Text("You can enable this functionality in phone Settings."),
                  dismissButton: .default(Text("OK")))
        }
    }
}