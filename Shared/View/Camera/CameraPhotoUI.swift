//
//  CameraPhotoUI.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.05.21.
//

import SwiftUI

struct CameraPhotoUI: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    @Binding var showCamera: Bool
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    showCamera.toggle()
                }){
                    Image(systemName: "arrowshape.turn.up.left.fill")
                        .circleBackground
                }
                Spacer()
                Button(action:{
                    cameraViewModel.reTake()
                }){
                    Image(systemName: "camera.fill")
                        .circleBackground
                }
                
            }
            .padding()
            .padding(.horizontal, 10)
            Spacer()
            HStack{
                Button(action:{
                    homeViewModel.takedPhotoData = cameraViewModel.picData
                    showCamera.toggle()
                }){
                    Text("USE THIS PHOTO")
                        .bold()
                        .foregroundColor(.primary)
                        .padding(.horizontal, 20)
                        .padding(.vertical, 7)
                        .background(Color("Light").cornerRadius(10))
                }
                .padding()
                Spacer()
            }
        }
    }
}

struct CameraPhotoUI_Previews: PreviewProvider {
    static var previews: some View {
        CameraPhotoUI(showCamera: .constant(true))
    }
}
