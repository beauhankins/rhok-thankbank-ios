//
//  ProfileController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright (c) 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class ProfileController: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    view.backgroundColor = Colors().BackgroundDark
  }
}