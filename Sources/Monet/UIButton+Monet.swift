//
//  UIButton+Monet.swift
//  Monet
//
//  Created by Benoit BRIATTE on 18/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import UIKit

public extension UIButton {

    public struct AppearanceOptions {
        public let autoAdjustBackgroundColor: Bool
        public let autoAdjustForegroundColor: Bool

        public init(autoAdjustBackgroundColor: Bool = true, autoAdjustForegroundColor: Bool = true) {
            self.autoAdjustBackgroundColor = autoAdjustBackgroundColor
            self.autoAdjustForegroundColor = autoAdjustForegroundColor
        }
    }

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
        self.drawAppearance(textAppearance, options: AppearanceOptions())
    }

    public func drawAppearance(_ textAppearance: TextAppearance?, options: AppearanceOptions) {
        super.drawAppearance(textAppearance)
        guard let appearance = textAppearance else {
            return
        }

        if self.buttonType == .custom && options.autoAdjustBackgroundColor,
            let backgroundColor = appearance.backgroundColor {
            self.backgroundColor = .clear
            self.setBackgroundImage(backgroundColor.imageRepresentation, for: .normal)
            self.setBackgroundImage(backgroundColor.highlighted.imageRepresentation, for: .highlighted)
            self.setBackgroundImage(backgroundColor.disabled.imageRepresentation, for: .disabled)
        }

        if let color = appearance.foregroundColor {
            self.setTitleColor(color, for: .normal)
            if self.buttonType == .custom && options.autoAdjustForegroundColor {
                self.setTitleColor(color.highlighted, for: .highlighted)
                self.setTitleColor(color.disabled, for: .disabled)
            }
        }
        if let font = appearance.font {
            self.titleLabel?.font = font
        }
    }
}
