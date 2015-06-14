//
//  RewardDetailController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class RewardDetailController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  let manager = AFHTTPRequestOperationManager()
  
  var coupons = []
  var reward: AnyObject?
  
  var imageData: NSData?
  var fbUserId: String?
  
  var selectedIndex: Int?
  
  let couponRewardsCellIdentifier = "CouponRewardsCell"
  
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
    label.text = self.coupons[0]["partner_name"] as! String?
    label.textColor = Colors().White
    label.font = Fonts().DefaultBold
    label.textAlignment = .Left
    return label
    }()
  lazy var retailerThumbImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = Colors().Primary
    imageView.image = UIImage(named: self.coupons[0]["partner_logo"] as! String)
    return imageView
    }()
  
  let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width - 24.0, 55.0)
    layout.scrollDirection = UICollectionViewScrollDirection.Vertical
    layout.minimumLineSpacing = 6.0
    return layout
    }()
  
   lazy var rewardsTable: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.clearColor()
    collectionView.showsVerticalScrollIndicator = false
    collectionView.registerClass(CouponRewardsCell.self, forCellWithReuseIdentifier: self.couponRewardsCellIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
    }()
  
  init(coupons: [AnyObject]) {
    self.coupons = coupons
    super.init(nibName: nil, bundle: nil)
    
    print(coupons)
  }

  required convenience init(coder aDecoder: NSCoder) {
    self.init(coupons: [Coupon(retailer: "no_retailer", description: "no_description")])
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchDefaults()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(navigationView)
    view.addSubview(retailerLabel)
    view.addSubview(retailerThumbImage)
    view.addSubview(rewardsTable)
    
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
    
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Top, relatedBy: .Equal, toItem: retailerThumbImage, attribute: .Bottom, multiplier: 1, constant: 35))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -navigationView.frame.height))
  }
  
  // MARK: - CollectionViewDelegate
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return coupons.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let i = indexPath.item
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(couponRewardsCellIdentifier, forIndexPath: indexPath) as! CouponRewardsCell
    
    cell.text = coupons[i]["name"] as? String
    cell.radioButton.tag = i
    cell.radioButton.addTarget(self, action: "toggleRadioSelected:", forControlEvents: .TouchUpInside)
    
    return cell
  }
  
  // MARK - Navigation
  
  func back() {
    navigationController?.popViewControllerAnimated(true)
  }
  
  func claimReward() {
    
    let _reward = reward as! NSDictionary
    let rewardName = _reward["name"] as! String
    let rewardRetailerName = _reward["partner_name"] as! String
    
    manager.requestSerializer.setValue("aaiu73nklx0hhb0imn05ipz4dztbnlgonlnhmfjx", forHTTPHeaderField: "X-Auth-Token")
    let parameters = ["facebook_uid":fbUserId!,
//                      "image":imageData!,
                      "coupon":["name":rewardName,"partner":["name":rewardRetailerName]]]
    
    manager.POST( "http://brisbane-thank-bank.herokuapp.com/api/v1/checkins",
      parameters: parameters,
      success: { (operation: AFHTTPRequestOperation!,responseObject: AnyObject!) in
        print("JSON: \(responseObject)")
        
        let thankYouController = ThankYouController()
        self.navigationController?.pushViewController(thankYouController, animated: true)
      },
      failure: { (operation: AFHTTPRequestOperation!,error: NSError!) in
        print("Error: \(error.localizedDescription)")
    })
  }
  
  func toggleRadioSelected(sender: AnyObject) {
    let radioButton = sender as! UIButton
    
    reward = coupons[radioButton.tag]
    
    for i in rewardsTable.subviews {
      if i.isKindOfClass(UICollectionViewCell){
        for view in i.subviews {
          if view.isKindOfClass(UIButton) {
            let button: UIButton = view as! UIButton
            button.selected = false
          }
        }
      }
    }
    
    radioButton.selected = !radioButton.selected
  }
  
  // MARK: - NSUserDefaults
  
  func fetchDefaults() {
    let defaults = NSUserDefaults.standardUserDefaults()
    
    imageData = defaults.objectForKey("checkin_image") as? NSData
    fbUserId = defaults.stringForKey("checkin_facebook_uid")
    
    print("\(fbUserId!)")
  }
}