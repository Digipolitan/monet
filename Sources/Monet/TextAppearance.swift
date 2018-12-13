//
//  TextAppearance.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import ObjectMapper

public class TextAppearance: ViewAppearance {
    public let foregroundColor: UIColor?
    public let font: UIFont?

    public static let foregroundColorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()
    public static let fontTransformer: FontTransform = {
        return FontTransform()
    }()

    public init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, border: BorderAppearance? = nil, foregroundColor: UIColor? = nil, font: UIFont? = nil) {
        self.foregroundColor = foregroundColor
        self.font = font
        super.init(backgroundColor: backgroundColor, tintColor: tintColor, border: border)
    }

    public required init(map: Map) throws {
        let selfClass = type(of: self)
        self.foregroundColor = try? map.value("foregroundColor", using: selfClass.foregroundColorTransformer)
        self.font = try? map.value("font", using: selfClass.fontTransformer)
        try super.init(map: map)
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        let selfClass = type(of: self)
        self.foregroundColor >>> (map["foregroundColor"], selfClass.foregroundColorTransformer)
        self.font >>> (map["font"], selfClass.fontTransformer)
    }

    public var attributes: [NSAttributedString.Key: Any] {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let fc = self.foregroundColor {
            attributes[NSAttributedString.Key.foregroundColor] = fc
        }
        if let bc = self.backgroundColor {
            attributes[NSAttributedString.Key.backgroundColor] = bc
        }
        if let font = self.font {
            attributes[NSAttributedString.Key.font] = font
        }
        return attributes
    }
}

public extension UILabel {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
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

public extension UIButton {

    public struct AppearanceOptions {
        public let autoAdjustBackgroundColor: Bool
        public let autoAdjustForegroundColor: Bool

        public init(autoAdjustBackgroundColor: Bool = true, autoAdjustForegroundColor: Bool = true) {
            self.autoAdjustBackgroundColor = autoAdjustBackgroundColor
            self.autoAdjustForegroundColor = autoAdjustForegroundColor
        }
    }

    public func setAppearance(_ textAppearance: TextAppearance?) {
        self.setAppearance(textAppearance, options: AppearanceOptions())
    }

    public func setAppearance(_ textAppearance: TextAppearance?, options: AppearanceOptions) {
        super.setAppearance(textAppearance)
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

public extension UITextField {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
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

    public func setPlaceholderAppearance(_ textAppearance: TextAppearance?, placeholder: String) {
        if let appearance = textAppearance {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: appearance.attributes)
        } else {
            self.placeholder = placeholder
        }
    }
}

public extension UITextView {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
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
