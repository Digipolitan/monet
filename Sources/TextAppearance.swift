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
}

public extension UILabel {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
        guard let appearance = textAppearance else {
            return
        }
        if let fc = appearance.foregroundColor {
            self.textColor = fc
        }
        if let f = appearance.font {
            self.font = f
        }
    }
}

public extension UIButton {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
        guard let appearance = textAppearance else {
            return
        }
        if let fc = appearance.foregroundColor {
            self.setTitleColor(fc, for: .normal)
        }
        if let f = appearance.font {
            self.titleLabel?.font = f
        }
    }
}

public extension UITextField {

    public func setAppearance(_ textAppearance: TextAppearance?) {
        super.setAppearance(textAppearance)
        guard let appearance = textAppearance else {
            return
        }
        if let fc = appearance.foregroundColor {
            self.textColor = fc
        }
        if let f = appearance.font {
            self.font = f
        }
    }

    public func setPlaceholderAppearance(_ textAppearance: TextAppearance?, placeholder: String) {
        if let appearance = textAppearance {
            var attributes: [NSAttributedStringKey: Any] = [:]
            if let fc = appearance.foregroundColor {
                attributes[NSAttributedStringKey.foregroundColor] = fc
            }
            if let bc = appearance.backgroundColor {
                attributes[NSAttributedStringKey.backgroundColor] = bc
            }
            if let f = appearance.font {
                attributes[NSAttributedStringKey.font] = f
            }
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: attributes)
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
        if let fc = appearance.foregroundColor {
            self.textColor = fc
        }
        if let f = appearance.font {
            self.font = f
        }
    }
}
