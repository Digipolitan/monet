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

    public init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, border: BorderAppearance? = nil, foregroundColor: UIColor? = nil, font: UIFont? = nil) {
        self.foregroundColor = foregroundColor
        self.font = font
        super.init(backgroundColor: backgroundColor, tintColor: tintColor, border: border)
    }

    public required init(map: Map) throws {
        self.foregroundColor = map.color(key: "foregroundColor")
        self.font = map.font(key: "font")
        try super.init(map: map)
    }

    public override func mapping(map: Map) {
        super.mapping(map: map)
        self.foregroundColor >>> (map["foregroundColor"], Monet.Transformers.colorTransformer)
        self.font >>> (map["font"], Monet.Transformers.fontTransformer)
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
