//
//  ChooseRewardController.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class ChooseRewardController: UIViewController {
  
  var image: UIImage?
  
  let flowLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    layout.itemSize = CGSizeMake(UIScreen.mainScreen().bounds.width, 80.0)
    layout.scrollDirection = UICollectionViewScrollDirection.Vertical
    return layout
  }()
  
  
  lazy var rewardsTable: UICollectionView = {
    let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: self.flowLayout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = UIColor.clearColor()
    collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "RewardsCell")
    return collectionView
    }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    layoutInterface()
  }
  
  func layoutInterface() {
    self.view.backgroundColor = Colors().White
    
    self.view.addSubview(rewardsTable)
    
    self.view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Top, relatedBy: .Equal, toItem: self.view, attribute: .Top, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .CenterX, relatedBy: .Equal, toItem: self.view, attribute: .CenterX, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Width, relatedBy: .Equal, toItem: self.view, attribute: .Width, multiplier: 1, constant: 0))
    self.view.addConstraint(NSLayoutConstraint(item: rewardsTable, attribute: .Height, relatedBy: .Equal, toItem: self.view, attribute: .Height, multiplier: 1, constant: 0))
  }
}