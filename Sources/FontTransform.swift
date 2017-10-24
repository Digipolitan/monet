//
//  FontTransform.swift
//  Monet
//
//  Created by David LINHARES on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import ObjectMapper

public struct FontTransform: TransformType {

    public enum Keys {
        public static let name: String = "name"
        public static let size: String = "size"
    }

    public init() { }

    public func transformFromJSON(_ value: Any?) -> UIFont? {
        guard let json = value as? [String: Any],
            let name = json[Keys.name] as? String,
            let size = json[Keys.size] as? Int else {
            return nil
        }
        return UIFont(name: name, size: CGFloat(size))
    }

    public func transformToJSON(_ value: UIFont?) -> Any? {
        guard let font = value else {
            return nil
        }
        return [
            Keys.name: font.fontName,
            Keys.size: font.pointSize
        ]
    }
}
