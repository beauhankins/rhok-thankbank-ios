//
//  Settings.swift
//  ThankBank
//
//  Created by Beau Hankins on 13/06/2015.
//  Copyright (c) 2015 Beau Hankins. All rights reserved.
//

import Foundation
import UIKit

struct Colors {
  let White = UIColor(white: 1, alpha: 1)
  let Black = UIColor(white: 0, alpha: 1)
  let Primary = UIColor(red: (56/255.0), green: (170/255.0), blue: (255/255.0), alpha: 1)
  let Secondary = UIColor(red: (72/255.0), green: (84/255.0), blue: (255/255.0), alpha: 1)
}

struct Fonts {
  let Default = UIFont(name: "HelveticaNeue-Light", size: 18.0);
  let LargeHeading = UIFont(name: "HelveticaNeue-Light", size: 64.0)
  let Heading = UIFont(name: "HelveticaNeue-Regular", size: 18.0)
  let Caption = UIFont(name: "HelveticaNeue-Regular", size: 11.0)
  let Coordinate = UIFont(name: "HelveticaNeue-Regular", size: 16.0)
  let FormattedCoordinate = UIFont(name: "HelveticaNeue-Light", size: 16.0)
  let Unit = UIFont(name: "HelveticaNeue-Bold", size: 14.0)
}