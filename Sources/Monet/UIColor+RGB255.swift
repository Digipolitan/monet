//
//  UIColor+RGB255.swift
//  Monet
//
//  Created by Benoit BRIATTE on 02/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public extension UIColor {

    struct RGB255 {
        public var red: CGFloat
        public var green: CGFloat
        public var blue: CGFloat
        public var alpha: CGFloat

        public init(red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 1) {
            self.red = red
            self.green = green
            self.blue = blue
            self.alpha = alpha
        }

        public init(color: UIColor) {
            guard
                let components = color.cgColor.components,
                components.count > 0 else {
                    self.init()
                    return
            }
            let red: CGFloat = components[0] * 255
            if components.count > 2 {
                self.init(red: red, green: components[1] * 255, blue: components[2] * 255, alpha: color.cgColor.alpha)
            } else {
                self.init(red: red, green: red, blue: red, alpha: color.cgColor.alpha)
            }
        }

        public func color() -> UIColor {
            return UIColor(red: self.red / 255,
                           green: self.green / 255,
                           blue: self.blue / 255,
                           alpha: self.alpha)
        }
    }

    var rgb255: RGB255 {
        return RGB255(color: self)
    }
}
