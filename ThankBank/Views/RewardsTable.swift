//
//  RewardsTable.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

class RewardsCell: UICollectionViewCell {
  
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
    imageView.backgroundColor = Colors().Primary
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