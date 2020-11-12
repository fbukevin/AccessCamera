    //
    //  ViewController.swift
    //  openCamera
    //
    //  Created by Veck on 2017/1/5.
    //  Copyright © 2017年 Sanity. All rights reserved.
    //

    import Cocoa
    import AVFoundation

    class ViewController: NSViewController {
        
        @IBOutlet weak var camera: NSView!
        
        let captureSession = AVCaptureSession()
        var captureDevice : AVCaptureDevice?
        var previewLayer : AVCaptureVideoPreviewLayer?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            camera.layer = CALayer()
            
            
            // Do any additional setup after loading the view, typically from a nib.
            captureSession.sessionPreset = AVCaptureSession.Preset.low
            
            let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(
                deviceTypes: [ .builtInWideAngleCamera, .externalUnknown ],
                mediaType: .video,
                position: .unspecified
            )
            
            let devices = deviceDiscoverySession.devices
            
            // Find the FaceTime HD camera object
            
            for device in devices {
                print(device)
                
                // Camera object found and assign it to captureDevice
                if ((device as AnyObject).hasMediaType(AVMediaType.video)) {
                    print(device)
                    captureDevice = device as AVCaptureDevice
                }
            }
            
            
            if captureDevice != nil {
                
                do {
                    
                    try captureSession.addInput(AVCaptureDeviceInput(device: captureDevice!))
                    previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
                    previewLayer?.frame = (self.camera.layer?.frame)!
                    
                    // Add previewLayer into custom view
                    self.camera.layer?.addSublayer(previewLayer!)
                    
                    // Start camera
                    captureSession.startRunning()
                    
                } catch {
                    print(AVCaptureSessionErrorKey.description)
                }
            }
            
            
        }
        
        override var representedObject: Any? {
            didSet {
                // Update the view, if already loaded.
            }
        }
        
        
    }
