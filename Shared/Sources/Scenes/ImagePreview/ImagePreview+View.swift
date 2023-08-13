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
                appImage(.checkmark)
                    .resizable()
                    .frame(width: 80, height: 80)
                Text(appText(.generic(.saved)))
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
                AppButton(.appImage(.squareArrowDown), action: viewModel.onSaveTapped)
                    .opacity(viewModel.shouldShowSaveInPhotos ? 1 : 0)
            }
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                AppButton(.appImage(.xmark), action: viewModel.onCloseTapped)
            }
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text(appText(.imagePreview(.permissionErrorTitle))),
                  message: Text(appText(.imagePreview(.permissionErrorMessage))),
                  dismissButton: .default(Text(appText(.generic(.ok)))))
        }
    }
}
