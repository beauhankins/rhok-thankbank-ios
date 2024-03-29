//
//  RewardsTable.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class RetailerRewardsCell: UICollectionViewCell {
  
  var headline: String?
  var subline: String?
  var image: UIImage?
  
  lazy var headlineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.headline
    label.textColor = Colors().White
    label.font = Fonts().DefaultBold
    label.textAlignment = .Left
    return label
    }()
  
  lazy var sublineLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.subline
    label.textColor = Colors().Grey
    label.font = Fonts().Default
    label.textAlignment = .Left
    return label
    }()
  
  lazy var thumbImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.layer.cornerRadius = 20
    imageView.layer.masksToBounds = true
    imageView.backgroundColor = Colors().Primary
    imageView.image = self.image
    return imageView
    }()
  
  lazy var rightArrow: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "forward-dark")
    return imageView
    }()
  
  let borderBottom: CALayer = {
    let layer = CALayer()
    layer.backgroundColor = Colors().Grey.CGColor
    return layer
    }()
  
  override func layoutSubviews() {
    layer.addSublayer(borderBottom)
    addSubview(headlineLabel)
    addSubview(sublineLabel)
    addSubview(thumbImage)
    addSubview(rightArrow)
    
    borderBottom.frame = CGRectMake(0, self.frame.height - 0.5, self.frame.width, 0.5)
    
    addConstraint(NSLayoutConstraint(item: headlineLabel, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: -1))
    addConstraint(NSLayoutConstraint(item: headlineLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: headlineLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -140))
    
    addConstraint(NSLayoutConstraint(item: sublineLabel, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 1))
    addConstraint(NSLayoutConstraint(item: sublineLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: sublineLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -140))
    
    addConstraint(NSLayoutConstraint(item: thumbImage, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 1))
    addConstraint(NSLayoutConstraint(item: thumbImage, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 35))
    addConstraint(NSLayoutConstraint(item: thumbImage, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 40))
    addConstraint(NSLayoutConstraint(item: thumbImage, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 40))

    addConstraint(NSLayoutConstraint(item: rightArrow, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 1))
    addConstraint(NSLayoutConstraint(item: rightArrow, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: -35))
    addConstraint(NSLayoutConstraint(item: rightArrow, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 21))
    addConstraint(NSLayoutConstraint(item: rightArrow, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 17))
  }
}

class CouponRewardsCell: UICollectionViewCell {
  
  var text: String?
  var couponSelected: Bool = false
  
  lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = self.text
    label.textColor = Colors().Grey
    label.font = Fonts().Default
    label.textAlignment = .Left
    return label
    }()
  
  lazy var radioButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setBackgroundImage(UIImage(named: "unselected"), forState: .Normal)
    button.setBackgroundImage(UIImage(named: "selected"), forState: .Selected)
    return button
    }()
  
  override func layoutSubviews() {
    self.backgroundColor = Colors().White
    self.layer.cornerRadius = 2.0
    
    addSubview(textLabel)
    addSubview(radioButton)
    
    addConstraint(NSLayoutConstraint(item: textLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
    addConstraint(NSLayoutConstraint(item: textLabel, attribute: .Left, relatedBy: .Equal, toItem: self, attribute: .Left, multiplier: 1, constant: 13))
    addConstraint(NSLayoutConstraint(item: textLabel, attribute: .Width, relatedBy: .Equal, toItem: self, attribute: .Width, multiplier: 1, constant: -58))
    
    addConstraint(NSLayoutConstraint(item: radioButton, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 1))
    addConstraint(NSLayoutConstraint(item: radioButton, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .Right, multiplier: 1, constant: -28))
    addConstraint(NSLayoutConstraint(item: radioButton, attribute: .Width, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 32))
    addConstraint(NSLayoutConstraint(item: radioButton, attribute: .Height, relatedBy: .Equal, toItem: .None, attribute: .NotAnAttribute, multiplier: 1, constant: 32))
  }
}