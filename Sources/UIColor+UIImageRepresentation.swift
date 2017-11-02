//
//  UIColor+UIImageRepresentation.swift
//  Monet
//
//  Created by Benoit BRIATTE on 02/11/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public extension UIColor {

    public var imageRepresentation: UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }

        context.setFillColor(self.cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image
    }
}
