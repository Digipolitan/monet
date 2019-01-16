//
//  Theme.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import ObjectMapper

public class Theme: ImmutableMappable {

    public let identifier: String

    public let colors: [String: UIColor]

    public let fonts: [String: UIFont]

    public let appearances: AppearanceRegistry

    public required init(identifier: String,
                         colors: [String: UIColor],
                         fonts: [String: UIFont],
                         appearances: AppearanceRegistry) {
        self.identifier = identifier
        self.colors = colors
        self.fonts = fonts
        self.appearances = appearances
    }

    public convenience required init(map: Map) throws {
        let colors: [String: UIColor] = (try? map.value(Monet.Alias.colors, using: Monet.Transformers.colorTransformer)) ?? [:]
        let fonts: [String: UIFont] = (try? map.value(Monet.Alias.fonts, using: Monet.Transformers.fontTransformer)) ?? [:]
        map.context = Monet.Context(colors: colors, fonts: fonts)
        self.init(identifier: try map.value("identifier"),
                  colors: colors,
                  fonts: fonts,
                  appearances: try map.value("appearances"))
    }

    public func mapping(map: Map) {
        self.identifier >>> map["identifier"]
        self.colors >>> (map[Monet.Alias.colors], using: Monet.Transformers.colorTransformer)
        self.fonts >>> (map[Monet.Alias.fonts], using: Monet.Transformers.fontTransformer)
        self.appearances >>> map["appearances"]
    }
}

extension Theme: CustomStringConvertible {

    public var description: String {
        return self.toJSONString() ?? "{}"
    }
}

extension Theme {
    public static func from(jsonFile named: String, in bundle: Bundle = .main) throws -> Self {
        guard let url = bundle.url(forResource: named, withExtension: named.hasSuffix("json") ? nil : "json") else {
            throw MonetError.noSuchTheme(file: named)
        }
        guard
            let data = try? Data(contentsOf: url),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = object as? [String: Any] else {
                throw MonetError.malformatedTheme
        }
        return try self.init(map: Map(mappingType: .fromJSON, JSON: json))
    }
}
