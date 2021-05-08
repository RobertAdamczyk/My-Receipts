//
//  ImagePreview.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.04.21.
//

import SwiftUI

class ImagePreviewViewModel: NSObject, ObservableObject {
    @Published var offset = CGSize.zero
    @Published var showAlert = false
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }

    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print("Error saving image. \(error)")
            showAlert.toggle()
            return
        }
        
        print("Saved !")
    }
}

struct ImagePreview: View {
    @ObservedObject var viewModel = ImagePreviewViewModel()
    @Binding var selectedImage: UIImage?
    var body: some View {
        ZStack{
            if let image = selectedImage {
                Color("Layout").opacity( 1 - Double(abs(viewModel.offset.height) / 700))
                    
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: viewModel.offset.height)
                    .scaleEffect(1 - (abs(viewModel.offset.height) / 1000))
                Color.clear
                    .overlay(HStack{
                        Button(action:{
                            viewModel.writeToPhotoAlbum(image: image)
                        }){
                            Text("Save in Photos")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.primary)
                        .padding(4)
                        .padding(.horizontal, 3)
                        .background(RoundedRectangle(cornerRadius: 5)
                                        .foregroundColor(Color("Light")))
                        .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                        .padding(.leading, 10)
                        .opacity(viewModel.offset.height == 0 ? 1 : 0)
                    },alignment: .topLeading)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.viewModel.offset = gesture.translation
                }

                .onEnded { _ in
                    if self.viewModel.offset.height > 20 {
                        withAnimation{
                            self.viewModel.offset = CGSize(width: 0, height: 1000)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            selectedImage = nil
                            self.viewModel.offset = .zero
                        }
                    } else {
                        self.viewModel.offset = .zero
                    }
                }
        )
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("You haven't allowed this app to save photos."), message: Text("You can enable this functionality in IPhone Settings."), dismissButton: .default(Text("OK")))
                }
    }
}

struct ImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreview(selectedImage: .constant(UIImage(systemName: "person")))
            .preferredColorScheme(.light)
    }
}
