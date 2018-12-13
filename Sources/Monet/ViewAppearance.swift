//
//  ViewAppearence.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import ObjectMapper

public class BorderAppearance: ImmutableMappable {
    public let color: UIColor?
    public let cornerRadius: Double?
    public let width: Double?

    public static let colorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()

    public init(color: UIColor? = nil, cornerRadius: Double? = nil, width: Double? = nil) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.width = width
    }

    public required init(map: Map) throws {
        let selfClass = type(of: self)
        self.color = try? map.value("color", using: selfClass.colorTransformer)
        self.cornerRadius = try? map.value("cornerRadius")
        self.width = try? map.value("width")
    }

    public func mapping(map: Map) {
        let selfClass = type(of: self)
        self.color >>> (map["color"], selfClass.colorTransformer)
        self.cornerRadius >>> map["cornerRadius"]
        self.width >>> map["width"]
    }
}

public class ViewAppearance: ImmutableMappable, CustomStringConvertible {

    public let backgroundColor: UIColor?
    public let tintColor: UIColor?
    public let border: BorderAppearance?

    public static let backgroundColorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()
    public static let tintColorTransformer: HexColorTransform = {
        return HexColorTransform(prefixToJSON: true, alphaToJSON: true)
    }()

     public init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, border: BorderAppearance? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.border = border
     }

    public required init(map: Map) throws {
        let selfClass = type(of: self)
        self.backgroundColor = try? map.value("backgroundColor", using: selfClass.backgroundColorTransformer)
        self.tintColor = try? map.value("tintColor", using: selfClass.tintColorTransformer)
        self.border = try? map.value("border")
    }

    public func mapping(map: Map) {
        let selfClass = type(of: self)
        self.backgroundColor >>> (map["backgroundColor"], selfClass.backgroundColorTransformer)
        self.tintColor >>> (map["tintColor"], selfClass.tintColorTransformer)
        self.border >>> map["border"]
    }

    public var description: String {
        return self.toJSONString(prettyPrint: true) ?? "{}"
    }
}

public extension UIView {

    public func setAppearance(_ viewAppearance: ViewAppearance?) {
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
}
