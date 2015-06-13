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
  
  let captureSession = AVCaptureSession()
  var captureDevice: AVCaptureDevice?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
    configureCaptureSession()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().White
  }
  
  // MARK: - AVCapture
  
  func configureCaptureSession() {
    captureSession.sessionPreset = AVCaptureSessionPresetMedium
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
      
      let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
      self.view.layer.addSublayer(previewLayer)
      previewLayer?.frame = self.view.layer.frame
      captureSession.startRunning()
    } catch {
      print(error)
    }
  }
  
  func configureDevice() {
    if let device = captureDevice {
      do {
        try device.lockForConfiguration()
        device.focusMode = AVCaptureFocusMode.Locked
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
      let touchPercent = touch.locationInView(self.view).x / UIScreen.mainScreen().bounds.size.width
      focusTo(Float(touchPercent))
    }
    super.touchesBegan(touches, withEvent:event)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch: UITouch = touches.first {
      let touchPercent = touch.locationInView(self.view).x / UIScreen.mainScreen().bounds.size.width
      focusTo(Float(touchPercent))
    }
    super.touchesBegan(touches, withEvent:event)
  }
}