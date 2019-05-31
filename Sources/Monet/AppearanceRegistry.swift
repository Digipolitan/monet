//
//  AppearanceRegistry.swift
//  Monet
//
//  Created by Benoit BRIATTE on 16/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import ObjectMapper

public struct AppearanceRegistry: ImmutableMappable {

    public var views: [String: ViewAppearance]
    public var texts: [String: TextAppearance]

    public init(map: Map) throws {
        self.views = map["views"].isKeyPresent ? try map.value("views") : [:]
        self.texts = map["texts"].isKeyPresent ? try map.value("texts") : [:]
    }

    public func mapping(map: Map) {
        self.views >>> map["views"]
        self.texts >>> map["texts"]
    }
}

extension AppearanceRegistry: CustomStringConvertible {

    public var description: String {
        return self.toJSONString() ?? "{}"
    }
}
