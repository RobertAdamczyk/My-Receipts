//
//  CameraFullView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI

struct CameraFullView: View {
    @ObservedObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        ZStack{
            CameraPreview(camera: cameraViewModel).ignoresSafeArea()
            
            VStack{
                if cameraViewModel.isTaken {
                    HStack{
                        Spacer()
                        Button(action:{
                            
                        }){
                            Image(systemName: "camera.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 20)
                                .foregroundColor(.primary)
                                .background(Circle()
                                                .foregroundColor(Color("Light"))
                                                .frame(width: 45, height: 45))
                        }
                        .padding()
                    }
                    Spacer()
                    HStack{
                        Button(action:{
                            
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
                }else {
                    Spacer()
                    Button(action:{
                        cameraViewModel.isTaken.toggle()
                    }){
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                            .opacity(0.8)
                            .overlay(
                                Circle()
                                    .stroke()
                                    .frame(width: 70, height: 70)
                                    .foregroundColor(.white)
                            )
                    }
                }
            }
        }
    }
}

struct CameraFullView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFullView(cameraViewModel: CameraViewModel())
    }
}