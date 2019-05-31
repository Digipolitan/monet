//
//  UIView+Monet.swift
//  Monet
//
//  Created by Benoit BRIATTE on 18/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import UIKit

public extension UIView {

    struct AssociatedKeys {
        static var appearanceIdentifier: UInt8 = 0
    }

    @IBInspectable var appearanceIdentifier: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.appearanceIdentifier) as? String
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.appearanceIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN)
            if let id = newValue,
                let viewAppearance: ViewAppearance = Monet.shared.theme?.appearances.views[id] {
                self.drawAppearance(viewAppearance)
            }
        }
    }

    func drawAppearance(_ viewAppearance: ViewAppearance?) {
        guard let appearance = viewAppearance else {
            return
        }
        if let backgroundColor = appearance.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        if let tintColor = appearance.tintColor {
            self.tintColor = tintColor
        }
        if let border = appearance.border {
            self.clipsToBounds = true
            if let color = border.color {
                self.layer.borderColor = color.cgColor
            }
            if let width = border.width {
                self.layer.borderWidth = CGFloat(width)
            }
            if let corner = border.cornerRadius {
                self.layer.cornerRadius = CGFloat(corner)
            }
        }
    }

    func redrawAppearance() {
        let appearanceIdentifier = self.appearanceIdentifier
        self.appearanceIdentifier = appearanceIdentifier
        for child in self.subviews {
            child.redrawAppearance()
        }
    }
}
