//
//  CheckInController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright (c) 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class CheckInController: UIViewController {
  
  var image: UIImage?
  
  let captureSession = AVCaptureSession()
  var captureDevice: AVCaptureDevice?
  let imageOutput = AVCaptureStillImageOutput()
  
  lazy var captureButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = Colors().Primary
    button.addTarget(self, action: "takePhoto", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var approveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor.greenColor()
    button.addTarget(self, action: "approvePhoto", forControlEvents: .TouchUpInside)
    button.hidden = true
    return button
    }()
  
  lazy var disapproveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = UIColor.redColor()
    button.addTarget(self, action: "disapprovePhoto", forControlEvents: .TouchUpInside)
    button.hidden = true
    return button
    }()
  
  lazy var previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
    configureCaptureSession()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().Black
    self.view.layer.contentsGravity = kCAGravityResizeAspectFill
    
    self.view.layer.addSublayer(previewLayer)
    self.view.addSubview(captureButton)
    self.view.addSubview(approveButton)
    self.view.addSubview(disapproveButton)
    
    previewLayer.frame = self.view.layer.bounds
    previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    self.view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -20))
    self.view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
    self.view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
    
    self.view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -20))
    self.view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 0.5, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
    self.view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
    
    self.view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .Bottom, relatedBy: .Equal, toItem: self.view, attribute: .Bottom, multiplier: 1, constant: -20))
    self.view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1.5, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
    self.view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 55))
  }
  
  // MARK: - AVCapture
  
  func configureCaptureSession() {
    captureSession.sessionPreset = AVCaptureSessionPresetPhoto
    let devices = AVCaptureDevice.devices()
    
    for device in devices {
      if device.hasMediaType(AVMediaTypeVideo) {
        if device.position == AVCaptureDevicePosition.Back {
          captureDevice = device as? AVCaptureDevice
          if captureDevice != nil {
            beginSession()
          }
        }
      }
    }
  }
  
  func beginSession() {
    do {
      let deviceInput = try AVCaptureDeviceInput(device: captureDevice)
      captureSession.addInput(deviceInput)
      captureSession.startRunning()
      
      imageOutput.outputSettings = [AVVideoCodecKey:AVVideoCodecJPEG]
      if captureSession.canAddOutput(imageOutput) {
        captureSession.addOutput(imageOutput)
      }
    } catch {
      print(error)
    }
  }
  
  func configureDevice() {
    if let device = captureDevice {
      do {
        try device.lockForConfiguration()
        device.focusMode = AVCaptureFocusMode.AutoFocus
        device.unlockForConfiguration()
      } catch {
        print(error)
      }
    }
  }
  
  func focusTo(value : Float) {
    if let device = captureDevice {
      do {
        try device.lockForConfiguration()
        device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
          print(value)
        })
        device.unlockForConfiguration()
      } catch {
        print(error)
      }
    }
  }
  
  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch: UITouch = touches.first {
      let touchPercent = touch.locationInView(self.view).x / UIScreen.mainScreen().bounds.width
      focusTo(Float(touchPercent))
    }
    super.touchesBegan(touches, withEvent:event)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch: UITouch = touches.first {
      let touchPercent = touch.locationInView(self.view).x / UIScreen.mainScreen().bounds.width
      focusTo(Float(touchPercent))
    }
    super.touchesBegan(touches, withEvent:event)
  }
  
  // MARK - Take Photo
  
  func takePhoto() {
    print("Take Photo")
    if let videoConnection = imageOutput.connectionWithMediaType(AVMediaTypeVideo) {
      imageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection) {
        (imageDataSampleBuffer, error) -> Void in
        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(imageDataSampleBuffer)
        self.image = UIImage(data: imageData)
        self.showPreview()
      }
    }
  }
  
  // MARK - Preview
  
  func showPreview() {
    print(image!)
    previewLayer.hidden = true
    self.view.layer.contents = image!.CGImage
    
    captureButton.hidden = true
    approveButton.hidden = false
    disapproveButton.hidden = false
  }
  
  func hidePreview() {
    previewLayer.hidden = false
    self.view.layer.contents = nil
    
    captureButton.hidden = false
    approveButton.hidden = true
    disapproveButton.hidden = true
  }
  
  // MARK - Approval
  
  func approvePhoto() {
    print("Navigation: Choose Reward Controller", appendNewline: false)
    let chooseRewardController = ChooseRewardController()
    navigationController?.pushViewController(chooseRewardController, animated: true)
  }
  
  func disapprovePhoto() {
    hidePreview()
  }
}