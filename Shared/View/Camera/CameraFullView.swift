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
                if !cameraViewModel.showAlert && !cameraViewModel.isDetermining {
                    if cameraViewModel.isTaken{
                        CameraPhotoUI(showCamera: $showCamera)
                    }else{
                        CameraLiveUI(showCamera: $showCamera)
                    }
                }
                
            }
            .contentShape(Rectangle())
        }
        .environmentObject(cameraViewModel)
        .onAppear(){
            cameraViewModel.check()
        }
        .alert(isPresented: $cameraViewModel.showAlert) {
            Alert(title: Text("You haven't allowed this app to use camera."), message: Text("You can enable this functionality in IPhone Settings."), dismissButton: .default(Text("OK"), action: {
                showCamera = false
            }))
                }
    }
}

struct CameraFullView_Previews: PreviewProvider {
    static var previews: some View {
        CameraFullView(showCamera: .constant(true))
    }
}
