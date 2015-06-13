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
    button.setBackgroundImage(UIImage(named: "camera"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "camera-pressed"), forState: .Highlighted)
    button.addTarget(self, action: "takePhoto", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
    button.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var approveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "confirm-camera"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "confirm-camera-pressed"), forState: .Highlighted)
    button.addTarget(self, action: "approvePhoto", forControlEvents: .TouchUpInside)
    button.hidden = true
    return button
    }()
  
  lazy var disapproveButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "cancel-camera"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "cancel-camera-pressed"), forState: .Highlighted)
    button.addTarget(self, action: "disapprovePhoto", forControlEvents: .TouchUpInside)
    button.hidden = true
    return button
    }()
  
  lazy var hintLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Take a photo as proof of your good deed"
    label.textColor = Colors().White
    label.font = Fonts().DefaultBold
    label.textAlignment = .Center
    return label
    }()
  
  lazy var topEdgeGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 98)
    gradient.colors = [UIColor(white: 0.0, alpha: 0.9).CGColor, UIColor.clearColor().CGColor]
    gradient.locations = [0.0, 1.0]
    return gradient
    }()
  
  lazy var bottomEdgeGradient: CAGradientLayer = {
    let gradient = CAGradientLayer()
    gradient.frame = CGRectMake(0, UIScreen.mainScreen().bounds.height - 98, UIScreen.mainScreen().bounds.width, 98)
    gradient.colors = [UIColor.clearColor().CGColor, UIColor(white: 0.0, alpha: 0.9).CGColor]
    gradient.locations = [0.0, 1.0]
    return gradient
    }()
  
  lazy var edgeGradients: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.addSublayer(self.topEdgeGradient)
    view.layer.addSublayer(self.bottomEdgeGradient)
    return view
  }()
  
  lazy var previewImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .ScaleAspectFill
    imageView.autoresizingMask = [.FlexibleRightMargin, .FlexibleLeftMargin, .FlexibleBottomMargin, .FlexibleTopMargin, .FlexibleWidth, .FlexibleHeight]
    return imageView
    }()
  
  lazy var videoPreviewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
    configureCaptureSession()
  }
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func layoutInterface() {
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
    
    view.backgroundColor = Colors().BackgroundDark
    view.layer.contentsGravity = kCAGravityResizeAspectFill
    
    view.layer.addSublayer(videoPreviewLayer)
    view.addSubview(previewImage)
    view.addSubview(edgeGradients)
    view.addSubview(captureButton)
    view.addSubview(backButton)
    view.addSubview(approveButton)
    view.addSubview(disapproveButton)
    view.addSubview(hintLabel)
    
    videoPreviewLayer.frame = view.layer.bounds
    videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
    
    view.addConstraint(NSLayoutConstraint(item: previewImage, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: previewImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: previewImage, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: previewImage, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0))
    
    view.addConstraint(NSLayoutConstraint(item: edgeGradients, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: edgeGradients, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: edgeGradients, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: edgeGradients, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: 0))
    
    view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -49))
    view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    view.addConstraint(NSLayoutConstraint(item: captureButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -49))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 25))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 21))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 17))
    
    view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -49))
    view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1.5, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    view.addConstraint(NSLayoutConstraint(item: approveButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    
    view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -49))
    view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 0.5, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    view.addConstraint(NSLayoutConstraint(item: disapproveButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 58))
    
    view.addConstraint(NSLayoutConstraint(item: hintLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 49))
    view.addConstraint(NSLayoutConstraint(item: hintLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: hintLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
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
      let touchPercent = touch.locationInView(view).x / UIScreen.mainScreen().bounds.width
      focusTo(Float(touchPercent))
    }
    super.touchesBegan(touches, withEvent:event)
  }
  
  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    if let touch: UITouch = touches.first {
      let touchPercent = touch.locationInView(view).x / UIScreen.mainScreen().bounds.width
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
    videoPreviewLayer.hidden = true
    previewImage.image = image!
    
    hintLabel.text = "Use this photo as proof? "
    captureButton.hidden = true
    backButton.hidden = true
    approveButton.hidden = false
    disapproveButton.hidden = false
  }
  
  func hidePreview() {
    videoPreviewLayer.hidden = false
    previewImage.image = nil
    
    hintLabel.text = "Take a photo as proof of your good deed"
    captureButton.hidden = false
    backButton.hidden = false
    approveButton.hidden = true
    disapproveButton.hidden = true
  }
  
  // MARK - Approval
  
  func approvePhoto() {
    let chooseRewardController = ChooseRewardController()
    navigationController?.pushViewController(chooseRewardController, animated: true)
  }
  
  func disapprovePhoto() {
    hidePreview()
  }
  
  // MARK - Navigation
  
  func back() {
    navigationController?.popViewControllerAnimated(true)
  }
}