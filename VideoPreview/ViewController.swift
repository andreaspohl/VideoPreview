//
//  ViewController.swift
//  VideoPreview
//
//  Created by Andreas Pohl on 31.12.17.
//  Copyright © 2017 Andreas Pohl. All rights reserved.
//

import Cocoa
import AVFoundation
import AVKit

class ViewController: NSViewController {
    
    @IBOutlet var myView: NSView!
    @IBOutlet weak var imageView: NSImageView!
    
    @IBAction func toggleMaskButton(_ sender: NSButton) {
        if (imageView.alphaValue == 0.5) {
            imageView.alphaValue = 0.0
        } else {
            imageView.alphaValue = 0.5
        }
    }
    
    let session = AVCaptureSession()
    let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        do {
            
            session.sessionPreset = AVCaptureSessionPresetHigh
            
            try device?.lockForConfiguration()
            
            device?.focusMode = AVCaptureFocusMode.continuousAutoFocus
            device?.exposureMode = AVCaptureExposureMode.continuousAutoExposure
            //device?.whiteBalanceMode = AVCaptureWhiteBalanceMode.continuousAutoWhiteBalance
            
            device?.unlockForConfiguration()
            
            let deviceInput = try AVCaptureDeviceInput(device: device)
            
            if (session.canAddInput(deviceInput)) {
                session.addInput(deviceInput)
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            
            myView.layer = previewLayer!
            myView.wantsLayer = true
            
            
            session.startRunning()
            
            let mask = NSImage(byReferencingFile: "/Users/andreas/Movies/0_mask/horseSampleShotMask.png")
            
            imageView.image = mask
            
            imageView.alphaValue = 0.5

            
        }
        catch let error as NSError {
            NSLog("\(error), \(error.localizedDescription)")
        }
        
    }
    
    override var representedObject: Any? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}


