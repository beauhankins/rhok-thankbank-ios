//
//  RewardDetailController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class RewardDetailController: UIViewController {
  
  let manager = AFHTTPRequestOperationManager()
  
  var retailer: String?
  
  lazy var backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
    button.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var claimButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "claim-reward"), forState: .Normal)
    button.addTarget(self, action: "claimReward", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var navigationView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = Colors().Black
    
    view.addSubview(self.backButton)
    view.addSubview(self.claimButton)
    
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 25))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 21))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 17))
    
    view.addConstraint(NSLayoutConstraint(item: self.claimButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: self.claimButton, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1, constant: -8))
    view.addConstraint(NSLayoutConstraint(item: self.claimButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 137))
    view.addConstraint(NSLayoutConstraint(item: self.claimButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 37))
    
    return view
    }()
  
  lazy var retailerLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.retailer
    label.textColor = Colors().White
    label.font = Fonts().DefaultBold
    label.textAlignment = .Left
    return label
    }()
  lazy var retailerThumbImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.backgroundColor = Colors().Primary
    return imageView
    }()
  
  init(retailer: String) {
    self.retailer = retailer
    super.init(nibName: nil, bundle: nil)
  }

  required convenience init(coder aDecoder: NSCoder) {
    self.init(retailer: "-")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(navigationView)
    view.addSubview(retailerLabel)
    view.addSubview(retailerThumbImage)
    
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 75))
    
    view.addConstraint(NSLayoutConstraint(item: retailerLabel, attribute: .CenterY, relatedBy: .Equal, toItem: navigationView, attribute: .Bottom, multiplier: 1, constant: 35))
    view.addConstraint(NSLayoutConstraint(item: retailerLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: retailerLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: -140))
    
    view.addConstraint(NSLayoutConstraint(item: retailerThumbImage, attribute: .CenterY, relatedBy: .Equal, toItem: navigationView, attribute: .Bottom, multiplier: 1, constant: 35))
    view.addConstraint(NSLayoutConstraint(item: retailerThumbImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 35))
    view.addConstraint(NSLayoutConstraint(item: retailerThumbImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 40))
    view.addConstraint(NSLayoutConstraint(item: retailerThumbImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 40))
  }
  
  // MARK - Navigation
  
  func back() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func claimReward() {
    manager.requestSerializer.setValue("608c6c08443c6d933576b90966b727358d0066b4", forHTTPHeaderField: "X-Auth-Token")
    let parameters = ["user_id":"",
                      "image":"",
                      "coupon_id":""]
    
    manager.POST( "http://",
      parameters: parameters,
      success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        print("JSON: " + responseObject.description)
        
        let thankYouController = ThankYouController()
        self.navigationController?.pushViewController(thankYouController, animated: true)
      },
      failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
        print("Error: " + error.localizedDescription)
      })
  }
}