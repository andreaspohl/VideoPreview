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
            
/*
            let captureOutput = AVCaptureVideoDataOutput()
            
            captureOutput.alwaysDiscardsLateVideoFrames = true
            
            let queue = DispatchQueue(label: "videoQueue")
            
            captureOutput.setSampleBufferDelegate(self, queue: queue)
            
            if (session.canAddOutput(captureOutput)) {
                session.addOutput(captureOutput)
            }
 */
            
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

extension ViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {
        //add code here
    }
    
}

