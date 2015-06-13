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
  
  lazy var coinImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "falling-coin")
    return imageView
    }()
  
  lazy var vaultImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "vault")
    return imageView
  }()
  
  lazy var checkInButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "check-in"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "check-in-pressed"), forState: .Highlighted)
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
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func layoutInterface() {
    UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: .Slide)
    
    view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(vaultImage)
    view.addSubview(coinImage)
    view.addSubview(checkInButton)
    
    view.addConstraint(NSLayoutConstraint(item: vaultImage, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: vaultImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: vaultImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 265.0))
    view.addConstraint(NSLayoutConstraint(item: vaultImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 161.0))
    
    view.addConstraint(NSLayoutConstraint(item: coinImage, attribute: .Bottom, relatedBy: .Equal, toItem: vaultImage, attribute: .Top, multiplier: 1, constant: -20))
    view.addConstraint(NSLayoutConstraint(item: coinImage, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: coinImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 95.0))
    view.addConstraint(NSLayoutConstraint(item: coinImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 135.0))
    
    view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .Top, relatedBy: .Equal, toItem: vaultImage, attribute: .Bottom, multiplier: 1, constant: 40))
    view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 265.0))
    view.addConstraint(NSLayoutConstraint(item: checkInButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 47.0))
  }
  
  // MARK: - Navigation
  
  func checkInController() {
    let checkInAlert = UIAlertController(title: "Please connect with facebook to win and share your prizes", message: nil, preferredStyle: .Alert)
    
    let cancelAction = UIAlertAction(title: "No Thanks", style: .Cancel, handler: { (action: UIAlertAction!) -> Void in
      let checkInController = CheckInController()
      self.navigationController?.pushViewController(checkInController, animated: true)
    })
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) -> Void in
      let login = FBSDKLoginManager()
      login.logInWithPublishPermissions(["publish_actions"]) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
        if error != nil {
          // Process error
        } else if result.isCancelled {
          // Handle cancellations
        } else {
          let checkInController = CheckInController()
          self.navigationController?.pushViewController(checkInController, animated: true)
        }
      }
    })
    
    checkInAlert.addAction(cancelAction)
    checkInAlert.addAction(okAction)
    
    presentViewController(checkInAlert, animated: true, completion: nil)
    
    /*
    if FBSDKAccessToken.currentAccessToken().hasGranted("publish_actions") {
      FBSDKGraphRequest(graphPath: "me/feed", parameters: [ "message": "hello world" ], HTTPMethod: "POST").startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
        let resultId = result["id"]
        print("Post id: \(resultId)")
      })
    }
    */
  }
  
  func profileController() {
    let checkInController = ProfileController()
    navigationController?.pushViewController(checkInController, animated: true)
  }
}