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

    public let scene: ViewAppearance?

    public let body: TextAppearance?

    public let h1: TextAppearance?

    public let h2: TextAppearance?

    public let h3: TextAppearance?

    public let placeholder: TextAppearance?

    public let input: TextAppearance?

    public let action: TextAppearance?

    public let error: TextAppearance?

    public let success: TextAppearance?

    public convenience required init(file: String, bundle: Bundle = .main) throws {
        guard let url = bundle.url(forResource: file, withExtension: file.hasSuffix("json") ? nil : "json") else {
            throw ThemeError.noSuchTheme(file: file)
        }
        guard
            let data = try? Data(contentsOf: url),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments),
            let json = object as? [String: Any] else {
                throw ThemeError.malformatedTheme
        }
        try self.init(map: Map(mappingType: .fromJSON, JSON: json))
    }

    public required init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.scene = try? map.value("scene")
        self.body = try? map.value("body")
        self.h1 = try? map.value("h1")
        self.placeholder = try? map.value("placeholder")
        self.input = try? map.value("input")
        self.h2 = try? map.value("h2")
        self.h3 = try? map.value("h3")
        self.action = try? map.value("action")
        self.error = try? map.value("error")
        self.success = try? map.value("success")
    }

    public func mapping(map: Map) {
        self.identifier >>> map["identifier"]
        self.scene >>> map["scene"]
        self.body >>> map["body"]
        self.h1 >>> map["h1"]
        self.placeholder >>> map["placeholder"]
        self.input >>> map["input"]
        self.h2 >>> map["h2"]
        self.h3 >>> map["h3"]
        self.action >>> map["action"]
        self.error >>> map["error"]
        self.success >>> map["success"]
    }
}

extension Theme: CustomStringConvertible {

    public var description: String {
        return self.toJSONString() ?? "{}"
    }
}
