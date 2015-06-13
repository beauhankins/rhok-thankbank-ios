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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(thankYouImage)
    
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 146))
    view.addConstraint(NSLayoutConstraint(item: thankYouImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 85))
  }
}