//
//  Theme.swift
//  Monet
//
//  Created by David LINHARES on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import ObjectMapper

public class Theme: ImmutableMappable {

    public let identifier: String

    public let body: TextAppearance

    public let h1: TextAppearance

    public let h2: TextAppearance?

    public let h3: TextAppearance?

    public let placeholder: TextAppearance

    public let input: TextAppearance

    public let link: TextAppearance?

    public let error: TextAppearance?

    public let success: TextAppearance?

    public convenience required init(file: String, bundle: Bundle = .main) throws {
        guard let url = bundle.url(forResource: file, withExtension: file.hasSuffix("json") ? nil : "json") else {
            throw ThemeError.noSuchTheme(file: file)
        }
        guard
            let data = try? Data(contentsOf: url),
            let object = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) else {
            throw ThemeError.malformatedTheme
        }
        try self.init(JSONObject: object)
    }

    public required init(map: Map) throws {
        self.identifier = try map.value("identifier")
        self.body = try map.value("body")
        self.h1 = try map.value("h1")
        self.placeholder = try map.value("placeholder")
        self.input = try map.value("input")
        self.h2 = try? map.value("h2")
        self.h3 = try? map.value("h3")
        self.link = try? map.value("link")
        self.error = try? map.value("error")
        self.success = try? map.value("success")
    }
}
