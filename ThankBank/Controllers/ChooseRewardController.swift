//
//  ChooseRewardController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class ChooseRewardController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
  
  var retailers = []
  
  let retailerRewardsCellIdentifier = "RetailerRewardsCell"
  
  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Select a reward"
    label.textColor = Colors().White
    label.font = Fonts().DefaultBold
    label.sizeToFit()
    label.textAlignment = .Center
    return label
    }()
  
  lazy var backButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "back"), forState: .Normal)
    button.addTarget(self, action: "back", forControlEvents: .TouchUpInside)
    return button
    }()
  
  lazy var navigationView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = Colors().Black
    
    view.addSubview(self.backButton)
    view.addSubview(self.titleLabel)
    
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1, constant: 25))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 21))
    view.addConstraint(NSLayoutConstraint(item: self.backButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 17))
    
    view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 10))
    view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: self.titleLabel, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: -100))
    
    return view
  }()
  
  let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 80.0)
    layout.scrollDirection = UICollectionViewScrollDirection.Vertical
    layout.minimumLineSpacing = 0.0
    return layout
  }()
  
  lazy var rewardsTable: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.clearColor()
    collectionView.showsVerticalScrollIndicator = false
    collectionView.registerClass(RetailerRewardsCell.self, forCellWithReuseIdentifier: self.retailerRewardsCellIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    fetchRewards()
    layoutInterface()
  }
  
  // MARK: - Interface
  
  override func prefersStatusBarHidden() -> Bool {
    return true
  }
  
  func layoutInterface() {
    UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: .Slide)
    
    view.backgroundColor = Colors().BackgroundDark
    
    view.addSubview(rewardsTable)
    view.addSubview(navigationView)
    
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: navigationView, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 75))
    
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Top, relatedBy: .Equal, toItem: navigationView, attribute: .Bottom, multiplier: 1, constant: -20))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Width, relatedBy: .Equal, toItem: view, attribute: .Width, multiplier: 1, constant: 0))
    view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Height, relatedBy: .Equal, toItem: view, attribute: .Height, multiplier: 1, constant: -navigationView.frame.height))
  }
  
  // MARK: - CollectionViewDelegate
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return retailers.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let i = indexPath.item
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(retailerRewardsCellIdentifier, forIndexPath: indexPath) as! RetailerRewardsCell
    
    cell.headline = String(retailers[i]["name"]!)
    
    let coupons = retailers[i]["coupons"] as! NSArray
    
    if coupons.count == 1 {
      cell.subline = "Choose from 1 coupon"
    } else {
      cell.subline = "Choose from \(coupons.count) coupons"
    }
    
    cell.image = UIImage(named: String(retailers[i]["logo"]!))
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let i = indexPath.item
    
    let coupons = retailers[i]["coupons"] as! [AnyObject]
    
    let rewardDetailController = RewardDetailController(coupons: coupons)
    navigationController?.pushViewController(rewardDetailController, animated: true)
  }
  
  // MARK - Networking
  
  func fetchRewards() {
    let dummyRetailers = [["name":"Boost Juice","logo":"boost","coupons":[
                            ["partner_name":"Boost Juice","partner_logo":"boost","name":"Free Boost juice"]]],
                          ["name":"McDonalds","logo":"mcdonalds","coupons":[
                            ["partner_name":"McDonalds","partner_logo":"mcdonalds","name":"Free McChicken"],
                            ["partner_name":"McDonalds","partner_logo":"mcdonalds","name":"Free Big Mac"],
                            ["partner_name":"McDonalds","partner_logo":"mcdonalds","name":"Buy one get one free large frozen coke"]]],
                          ["name":"JB HiFi","logo":"jbhifi","coupons":[
                            ["partner_name":"JB HiFi","partner_logo":"jbhifi","name":"20% off store-wide"],
                            ["partner_name":"JB HiFi","partner_logo":"jbhifi","name":"$25 Gift Card"]]],
                          ["name":"Tonic Espresso","logo":"tonic","coupons":[
                            ["partner_name":"Tonic Espresso","partner_logo":"tonic","name":"Free cafe latte"],
                            ["partner_name":"Tonic Espresso","partner_logo":"tonic","name":"Free cappuccino"]]]]
    retailers = dummyRetailers
  }
  
  // MARK - Navigation
  
  func back() {
    print("Navigation: Back", appendNewline: false)
    navigationController?.popViewControllerAnimated(true)
  }
}