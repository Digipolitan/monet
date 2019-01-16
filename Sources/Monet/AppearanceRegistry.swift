//
//  AppearanceRegistry.swift
//  Monet
//
//  Created by Benoit BRIATTE on 16/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import ObjectMapper

public class AppearanceRegistry: ImmutableMappable {

    public var views: [String: ViewAppearance]
    public var texts: [String: TextAppearance]

    public required init(map: Map) throws {
        self.views = (try? map.value("views")) ?? [:]
        self.texts = (try? map.value("texts")) ?? [:]
    }

    public subscript(key: String) -> ViewAppearance? {
        return self.views[key] ?? self.texts[key]
    }
}
