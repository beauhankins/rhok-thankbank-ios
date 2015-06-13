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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().White
  }
  
  func configureCaptureSession() {
    
  }
}