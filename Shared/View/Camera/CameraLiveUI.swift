//
//  CameraLiveUI.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.05.21.
//

import SwiftUI

struct CameraLiveUI: View {
    @EnvironmentObject var cameraViewModel: CameraViewModel
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
            }
            .padding()
            .padding(.horizontal, 10)
            Spacer()
            Button(action:{
                cameraViewModel.takePic()
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

struct CameraLiveUI_Previews: PreviewProvider {
    static var previews: some View {
        CameraLiveUI(showCamera: .constant(true))
    }
}
