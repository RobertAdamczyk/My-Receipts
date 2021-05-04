//
//  CameraViewModel.swift
//  CoreDataTest (iOS)
//
//  Created by Robert Adamczyk on 02.05.21.
//

import SwiftUI
import AVFoundation

class CameraViewModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var isTaken = false
    @Published var session = AVCaptureSession()
    @Published var showAlert = false
    @Published var isDetermining = false
    @Published var output = AVCapturePhotoOutput()
    @Published var preview: AVCaptureVideoPreviewLayer!
    @Published var picData = Data(count: 0)
    
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
            let device = AVCaptureDevice.default(for: .video)
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
    
    func takePic() {
        self.output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        
    }
    
    func reTake() {
        DispatchQueue.global(qos: .background).async {
            self.session.startRunning()
            
            DispatchQueue.main.async {
                withAnimation{
                    self.isTaken.toggle()
                    self.picData = Data(count: 0)
                }
            }
        }
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if error != nil {
            return
        }
        
        print("pic taken...")
        
        guard let imageData = photo.fileDataRepresentation() else {
            print("nil")
            return }
        
        self.picData = imageData
        
        self.session.stopRunning()
        
        DispatchQueue.main.async {
            withAnimation{
                self.isTaken.toggle()
            }
        }
    }
    
    
}
