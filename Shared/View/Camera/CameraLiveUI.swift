//
//  CameraLiveUI.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 03.05.21.
//

import SwiftUI

struct CameraLiveUI: View {
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
