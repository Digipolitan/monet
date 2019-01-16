//
//  MonetContext.swift
//  Monet
//
//  Created by Benoit BRIATTE on 16/01/2019.
//  Copyright © 2019 Digipolitan. All rights reserved.
//

import ObjectMapper

extension Monet {

    public enum Transformers {
        public static let colorTransformer: HexColorTransform = HexColorTransform(prefixToJSON: true, alphaToJSON: true)
        public static let fontTransformer: FontTransform = FontTransform()
    }

    struct Context: MapContext {
        var colors: [String: UIColor]
        var fonts: [String: UIFont]

        func search(existing color: String) -> UIColor? {
            if color.starts(with: Monet.Alias.colors) {
                var existing = color
                existing.removeSubrange(existing.startIndex ... existing.index(existing.startIndex, offsetBy: Monet.Alias.colors.count))
                return self.colors[existing]
            }
            return nil
        }

        func search(existing font: String) -> UIFont? {
            if font.starts(with: Monet.Alias.fonts) {
                var existing = font
                existing.removeSubrange(existing.startIndex ... existing.index(existing.startIndex, offsetBy: Monet.Alias.fonts.count))
                return self.fonts[existing]
            }
            return nil
        }
    }
}

extension Map {

    func color(key: String) -> UIColor? {
        if let context = self.context as? Monet.Context,
            let color: String = try? self.value(key),
            let res: UIColor = context.search(existing: color) {
            return res
        }
        return try? self.value(key, using: Monet.Transformers.colorTransformer)
    }

    func font(key: String) -> UIFont? {
        if let context = self.context as? Monet.Context,
            let font: String = try? self.value(key),
            let res: UIFont = context.search(existing: font) {
            return res
        }
        return try? self.value(key, using: Monet.Transformers.fontTransformer)
    }
}
