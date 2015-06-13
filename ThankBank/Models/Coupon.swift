//
//  Reward.swift
//  ThankBank
//
//  Created by Beau Hankins on 14/06/2015.
//  Copyright © 2015 Beau Hankins. All rights reserved.
//

import Foundation

class Coupon {
  var retailer: String!
  var description: String!
  
  init(retailer: String, description: String) {
    self.retailer = retailer
    self.description = description
  }
}