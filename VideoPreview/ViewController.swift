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
    
    @IBAction func togglePreviewButton(_ sender: NSButton) {
        if (myView.wantsLayer == true) {
            myView.wantsLayer = false
            session.stopRunning()
        } else {
            session.startRunning()
            myView.wantsLayer = true
        }
    }
    
    let session = AVCaptureSession()
    let device = AVCaptureDevice.default(for: AVMediaType.video)
    //let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        do {
            
            session.sessionPreset = AVCaptureSession.Preset.high
            
            try device?.lockForConfiguration()
            
            device?.focusMode = AVCaptureDevice.FocusMode.continuousAutoFocus
            device?.exposureMode = AVCaptureDevice.ExposureMode.continuousAutoExposure
            //device?.whiteBalanceMode = AVCaptureWhiteBalanceMode.continuousAutoWhiteBalance
            
            device?.unlockForConfiguration()
            
            let deviceInput = try AVCaptureDeviceInput(device: device!)
            
            if (session.canAddInput(deviceInput)) {
                session.addInput(deviceInput)
            }
            
            let previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
            myView.layer = previewLayer
            myView.wantsLayer = false // only if button is pressed later
            
            //set mask
            let moviesPath = NSSearchPathForDirectoriesInDomains(.moviesDirectory, .userDomainMask, true)[0]
            let mask = NSImage(byReferencingFile: moviesPath + "/0_mask/horseSampleShotMask.png")
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


