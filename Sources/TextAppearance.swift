//
//  TextAppearance.swift
//  Monet
//
//  Created by David LINHARES on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import ObjectMapper

public struct TextAppearance: Mappable {
    public let backgroundColor: UIColor
    public let foregroundColor: UIColor
    public let font: UIFont
    public static let backgroundColorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()
    public static let foregroundColorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()
    public static let fontTransformer: FontTransform = {
        return FontTransform()
    }()

    public enum Consts {
        public static let backgroundColor: UIColor = .clear
        public static let foregroundColor: UIColor = .black
        public static let font: UIFont = .preferredFont(forTextStyle: .body)
    }

    public init(backgroundColor: UIColor = Consts.backgroundColor, foregroundColor: UIColor = Consts.foregroundColor, font: UIFont = Consts.font) {
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.font = font
    }

    public init?(map: Map) {
        let selfClass = type(of: self)
        self.backgroundColor = (try? map.value("backgroundColor", using: selfClass.backgroundColorTransformer)) ?? Consts.backgroundColor
        self.foregroundColor = (try? map.value("foregroundColor", using: selfClass.foregroundColorTransformer)) ?? Consts.foregroundColor
        self.font = (try? map.value("font", using: selfClass.fontTransformer)) ?? Consts.font
    }

    public mutating func mapping(map: Map) {
        let selfClass = type(of: self)
        self.backgroundColor >>> (map["id"], selfClass.backgroundColorTransformer)
        self.foregroundColor >>> (map["email"], selfClass.foregroundColorTransformer)
        self.font >>> (map["phone_number"], selfClass.fontTransformer)
    }
}

extension TextAppearance {

    public func reverse() -> TextAppearance {
        return TextAppearance(backgroundColor: self.foregroundColor, foregroundColor: self.backgroundColor, font: self.font)
    }
}

public extension UILabel {

    public func setTextAppearance(_ textAppearance: TextAppearance) {
        self.backgroundColor = textAppearance.backgroundColor
        self.textColor = textAppearance.foregroundColor
        self.font = textAppearance.font
    }
}

public extension UIButton {

    public func setTextAppearance(_ textAppearance: TextAppearance) {
        self.backgroundColor = textAppearance.backgroundColor
        self.setTitleColor(textAppearance.foregroundColor, for: .normal)
        self.titleLabel?.font = textAppearance.font
    }
}

public extension UITextField {

    public func setTextAppearance(_ textAppearance: TextAppearance) {
        self.backgroundColor = textAppearance.backgroundColor
        self.textColor = textAppearance.foregroundColor
        self.font = textAppearance.font
    }

    public func setPlaceholderAppearance(_ textAppearance: TextAppearance, placeholder: String) {
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [
            NSAttributedStringKey.foregroundColor: textAppearance.foregroundColor,
            NSAttributedStringKey.backgroundColor: textAppearance.backgroundColor,
            NSAttributedStringKey.font: textAppearance.font
        ])
    }
}

public extension UITextView {

    public func setTextAppearance(_ textAppearance: TextAppearance) {
        self.backgroundColor = textAppearance.backgroundColor
        self.textColor = textAppearance.foregroundColor
        self.font = textAppearance.font
    }
}
