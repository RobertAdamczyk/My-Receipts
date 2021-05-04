//
//  ImagePreview.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 25.04.21.
//

import SwiftUI

struct ImagePreview: View {
    @State private var offset = CGSize.zero
    @Binding var selectedImage: UIImage?
    var body: some View {
        ZStack{
            if let image = selectedImage {
                Color("Layout").opacity( 1 - Double(abs(offset.height) / 700))
                    
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .offset(y: offset.height)
                    .scaleEffect(1 - (abs(offset.height) / 1000))
                Color.clear
                    .overlay(HStack{
                        Button(action:{
                            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
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
                        .opacity(offset.height == 0 ? 1 : 0)
                    },alignment: .topLeading)
            }
        }
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    self.offset = gesture.translation
                }

                .onEnded { _ in
                    if self.offset.height > 20 {
                        withAnimation{
                            self.offset = CGSize(width: 0, height: 1000)
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            selectedImage = nil
                            self.offset = .zero
                        }
                    } else {
                        self.offset = .zero
                    }
                }
        )
    }
}

struct ImagePreview_Previews: PreviewProvider {
    static var previews: some View {
        ImagePreview(selectedImage: .constant(UIImage(systemName: "person")))
            .preferredColorScheme(.light)
    }
}
