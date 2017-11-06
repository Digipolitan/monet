//
//  UIColor+UIControlState.swift
//  Monet
//
//  Created by Benoit BRIATTE on 02/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public extension UIColor {

    public var disabled: UIColor {
        return self.withAlphaComponent(self.cgColor.alpha / 1.89)
    }

    public var highlighted: UIColor {
        var rgb = self.rgb255
        rgb.red /= 1.89
        rgb.green /= 1.89
        rgb.blue /= 1.89
        return rgb.color()
    }
}
