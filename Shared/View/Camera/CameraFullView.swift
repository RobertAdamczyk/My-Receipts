//
//  CameraFullView.swift
//  My Receipts (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI

struct CameraFullView: View {

    @StateObject var cameraViewModel: CameraViewModel

    init(parentCoordinator: Coordinator, completion: @escaping (Data) -> Void) {
        self._cameraViewModel = .init(wrappedValue: .init(parentCoordinator: parentCoordinator,
                                                          completion: completion))
    }
    
    var body: some View {
        ZStack{
            CameraPreview(camera: cameraViewModel).ignoresSafeArea()
            
            VStack{
                if !cameraViewModel.showAlert && !cameraViewModel.isDetermining {
                    if cameraViewModel.isTaken{
                        CameraPhotoUI()
                    }else{
                        CameraLiveUI()
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
            Alert(title: Text("You haven't allowed this app to use camera."), message: Text("You can enable this functionality in phone Settings."), dismissButton: .default(Text("OK"), action: {
                cameraViewModel.dismiss()
            }))
        }
    }
}
