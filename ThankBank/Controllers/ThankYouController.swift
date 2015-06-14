//
//  ThankYouController.swift
//  ThankBank
//
//  Created by Beau Hankins on 14/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class ThankYouController: UIViewController {
  
  lazy var thankYouImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "thank-you")
    return imageView
    }()
  
  lazy var backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
    button.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
    return button
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(thankYouImage)
    view.addSubview(backButton)
    
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 146))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 85))
    
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1, constant: -49))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 25))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 21))
    view.addConstraint(NSLayoutConstraint(item: backButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 17))
  }
  
  // MARK - Navigation
  
  func back() {
    navigationController?.popToRootViewControllerAnimated(true)
  }
}