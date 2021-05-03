//
//  CameraFullView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI

struct CameraFullView: View {
    @ObservedObject var cameraViewModel = CameraViewModel()
    @Binding var showCamera: Bool
    
    var body: some View {
        ZStack{
            CameraPreview(camera: cameraViewModel).ignoresSafeArea()
            
            VStack{
                if cameraViewModel.isTaken {
                    HStack{
                        Button(action:{
                            showCamera.toggle()
                        }){
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .circleBackground
                        }
                        Spacer()
                        Button(action:{
                            cameraViewModel.isTaken.toggle()
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
                    HStack{
                        Button(action:{
                            showCamera.toggle()
                        }){
                            Image(systemName: "arrowshape.turn.up.left.fill")
                                .circleBackground
                        }
                        Spacer()
                    }
                    .padding()
                    .padding(.horizontal, 10)
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
            .contentShape(Rectangle())
        }
        .onAppear(){
            cameraViewModel.check()
        }
    }
}

struct CameraFullView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFullView(showCamera: .constant(true))
    }
}
