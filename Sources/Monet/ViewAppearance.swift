//
//  ViewAppearence.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit
import ObjectMapper
import ObjectiveC

public class BorderAppearance: ImmutableMappable {
    public let color: UIColor?
    public let cornerRadius: Double?
    public let width: Double?

    public init(color: UIColor? = nil, cornerRadius: Double? = nil, width: Double? = nil) {
        self.color = color
        self.cornerRadius = cornerRadius
        self.width = width
    }

    public required init(map: Map) throws {
        self.color = map.color(key: "color")
        self.cornerRadius = try? map.value("cornerRadius")
        self.width = try? map.value("width")
    }

    public func mapping(map: Map) {
        self.color >>> (map["color"], Monet.Transformers.colorTransformer)
        self.cornerRadius >>> map["cornerRadius"]
        self.width >>> map["width"]
    }
}

public class ViewAppearance: ImmutableMappable, CustomStringConvertible {

    public let backgroundColor: UIColor?
    public let tintColor: UIColor?
    public let border: BorderAppearance?

     public init(backgroundColor: UIColor? = nil, tintColor: UIColor? = nil, border: BorderAppearance? = nil) {
        self.backgroundColor = backgroundColor
        self.tintColor = tintColor
        self.border = border
     }

    public required init(map: Map) throws {
        self.backgroundColor = map.color(key: "backgroundColor")
        self.tintColor = map.color(key: "tintColor")
        self.border = try? map.value("border")
    }

    public func mapping(map: Map) {
        self.backgroundColor >>> (map["backgroundColor"], Monet.Transformers.colorTransformer)
        self.tintColor >>> (map["tintColor"], Monet.Transformers.colorTransformer)
        self.border >>> map["border"]
    }

    public var description: String {
        return self.toJSONString(prettyPrint: true) ?? "{}"
    }
}

extension ViewAppearance {
    public static func from(jsonFile named: String, in bundle: Bundle = .main) throws -> Self {
        guard let url = bundle.url(forResource: named, withExtension: named.hasSuffix("json") ? nil : "json") else {
            throw MonetError.noSuchAppearance(file: named)
        }
        guard
            let data = try? Data(contentsOf: url),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = object as? [String: Any] else {
                throw MonetError.malformatedAppearance
        }
        return try self.init(map: Map(mappingType: .fromJSON, JSON: json))
    }
}
