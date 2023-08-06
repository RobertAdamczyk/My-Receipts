//
//  CameraPhotoUI.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.05.21.
//

import SwiftUI

struct CameraPhotoUI: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        VStack{
            HStack{
                Button(action:{
                    cameraViewModel.dismiss()
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
                    cameraViewModel.completion(cameraViewModel.picData)
                    cameraViewModel.dismiss()
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
