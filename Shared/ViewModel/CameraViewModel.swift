//
//  CameraViewModel.swift
//  CoreDataTest (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI
import AVFoundation

class CameraViewModel: ObservableObject {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var showAlert = false
    @Published var isDetermining = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    
    func check() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            setUp()
            return
        case .notDetermined:
            isDetermining = true
            AVCaptureDevice.requestAccess(for: .video) { (status) in
                if status {
                    self.setUp()
                }
                DispatchQueue.main.async {
                    self.isDetermining = false
                    self.showAlert = true
                }
            }
        case .denied:
            showAlert = true
            return
        default:
            return
        }
    }
    
    func setUp() {
        do {
            session.beginConfiguration()
            let device = AVCaptureDevice.default(.builtInDualCamera, for: .video, position: .back)
            if let dev = device {
                let input = try AVCaptureDeviceInput(device: dev)
                
                if session.canAddInput(input) {
                    session.addInput(input)
                }
                
                if session.canAddOutput(output) {
                    session.addOutput(output)
                }
                
                session.commitConfiguration()
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
