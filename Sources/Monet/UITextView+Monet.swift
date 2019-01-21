//
//  UITextView+Monet.swift
//  Monet
//
//  Created by Benoit BRIATTE on 18/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import UIKit

public extension UITextView {

    public override var appearanceIdentifier: String? {
        get {
            return super.appearanceIdentifier
        }
        set {
            if let id = newValue,
                let textAppearance: TextAppearance = Monet.shared.theme?.appearances.texts[id] {
                objc_setAssociatedObject(self, &AssociatedKeys.appearanceIdentifier, newValue, .OBJC_ASSOCIATION_RETAIN)
                self.drawAppearance(textAppearance)
            } else {
                super.appearanceIdentifier = newValue
            }
        }
    }

    public func drawAppearance(_ textAppearance: TextAppearance?) {
        super.drawAppearance(textAppearance)
        guard let appearance = textAppearance else {
            return
        }
        if let color = appearance.foregroundColor {
            self.textColor = color
        }
        if let font = appearance.font {
            self.font = font
        }
    }
}
