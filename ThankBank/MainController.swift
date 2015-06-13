//
//  ViewController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright (c) 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class MainController: UIViewController {
  
  lazy var checkInButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Check In", forState: .Normal)
    button.setTitleColor(Colors().Black, forState: .Normal)
    button.addTarget(self, action: "checkInController", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var profileButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Profile", forState: .Normal)
    button.setTitleColor(Colors().Black, forState: .Normal)
    button.addTarget(self, action: "profileController", forControlEvents: .TouchUpInside)
    return button
    }()

  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  // MARK: - Interface
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().White
    
    self.view.addSubview(checkInButton)
    
    self.view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .CenterY, relatedBy: .Equal, toItem: self.view, attribute: .CenterY, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
  }
  
  // MARK: - Navigation
  
  func checkInController() {
    print("Navigation: Check-In Controller", appendNewline: false)
    let checkInController = CheckInController()
    navigationController?.pushViewController(checkInController, animated: true)
  }
  
  func profileController() {
    print("Navigation: Profile Controller", appendNewline: false)
    let checkInController = ProfileController()
    navigationController?.pushViewController(checkInController, animated: true)
  }
}