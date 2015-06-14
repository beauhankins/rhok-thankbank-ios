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
  
  let manager = AFHTTPRequestOperationManager()
  
  var fbUserId: String?
  
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
    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
    
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
      
    })
    let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (action: UIAlertAction!) -> Void in
      
      if FBSDKAccessToken.currentAccessToken() != nil {
        FBSDKGraphRequest(graphPath: "me", parameters: ["fields":"id,first_name,last_name,email"]).startWithCompletionHandler({ (connection: FBSDKGraphRequestConnection!, result: AnyObject!, error: NSError!) -> Void in
          if error != nil {
            print(error?.description)
          } else {
            print("Fetched facebook user: \(result)")
            
            self.fbUserId = result["id"] as? String
            let fbFirstName = result["first_name"] as! String
            let fbLastName = result["last_name"] as! String
            let fbEmail = result["email"] as! String
            let fbAvatarUrl = "https://graph.facebook.com/\(self.fbUserId!)/picture?type=large&return_ssl_resources=1"
            
            self.manager.requestSerializer.setValue("aaiu73nklx0hhb0imn05ipz4dztbnlgonlnhmfjx", forHTTPHeaderField: "X-Auth-Token")
            let userParameters = [ "user": ["facebook_uid":self.fbUserId!,
              "email":fbEmail,
              "first_name":fbFirstName,
              "last_name":fbLastName,
              "avatar_url":fbAvatarUrl] ]
            
            self.manager.POST( "http://brisbane-thank-bank.herokuapp.com/api/v1/users",
              parameters: userParameters,
              success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
                print("JSON: \(responseObject)")
                
                self.saveDefaults()
                
                let checkInController = CheckInController()
                self.navigationController?.pushViewController(checkInController, animated: true)
              },
              failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
                print("Error: \(error.localizedDescription)")
            })
          }
        })
      }
      
//      let login = FBSDKLoginManager()
//      login.logInWithReadPermissions(["email"]) { (result: FBSDKLoginManagerLoginResult!, error: NSError!) -> Void in
//        if error != nil {
//          // Process error
//        } else if result.isCancelled {
//          // Handle cancellations
//        } else {
//          
//        }
//      }
    })
    
    checkInAlert.addAction(cancelAction)
    checkInAlert.addAction(okAction)
    
//    if !FBSDKAccessToken.currentAccessToken().hasGranted("email") {
    presentViewController(checkInAlert, animated: true, completion: nil)
//    }
  }
  
  func profileController() {
    let checkInController = ProfileController()
    navigationController?.pushViewController(checkInController, animated: true)
  }
  
  // MARK: - NSUserDefaults
  
  func saveDefaults() {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    defaults.setObject(fbUserId, forKey: "checkin_facebook_uid")
  }
}