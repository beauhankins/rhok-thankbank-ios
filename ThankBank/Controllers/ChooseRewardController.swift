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
  
  let rewardsCellIdentifier = "RewardsCell"
  
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
    collectionView.registerClass(RewardsCell.self, forCellWithReuseIdentifier: self.rewardsCellIdentifier)
    collectionView.delegate = self
    collectionView.dataSource = self
    return collectionView
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
  
  let dummyRetailers = ["Boost Juice", "McDonalds", "JB Hi-Fi", "Tonic Espresso"]
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return 1
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 4
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let i = indexPath.item
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(rewardsCellIdentifier, forIndexPath: indexPath) as! RewardsCell
    
    cell.headline = dummyRetailers[i]
    cell.subline = "Your choice of one coupon"
    
    return cell
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    let i = indexPath.item
    
    let rewardDetailController = RewardDetailController(retailer: dummyRetailers[i])
    navigationController?.pushViewController(rewardDetailController, animated: true)
  }
  
  // MARK - Navigation
  
  func back() {
    print("Navigation: Back", appendNewline: false)
    navigationController?.popViewControllerAnimated(true)
  }
}