//
//  ThemeManager.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public class ThemeManager {

    public struct LoadConfiguration {
        public let bundle: Bundle
        public let type: Theme.Type
        public let infoKey: String

        public init(bundle: Bundle = .main, type: Theme.Type = Theme.self, infoKey: String = "Themes") {
            self.bundle = bundle
            self.type = type
            self.infoKey = infoKey
        }
    }

    public static var configuration = LoadConfiguration()

    public enum Keys {
        public static let currentTheme: String = "app.currentTheme"
    }

    public static let `shared`: ThemeManager = {
        do {
            return try ThemeManager()
        } catch {
            fatalError(error.localizedDescription)
        }
    }()

    public let themes: [Theme]

    public var current: Theme {
        didSet {
            let userDefaults = UserDefaults.standard
            userDefaults.set(current.identifier, forKey: Keys.currentTheme)
            userDefaults.synchronize()
        }
    }

    private init() throws {
        let configuration = ThemeManager.configuration
        guard let info = configuration.bundle.infoDictionary,
            let themeFiles = info[configuration.infoKey] as? [String] else {
                fatalError("[!] Missing or invalid theme list; set themes in Info.plist key '\(configuration.infoKey)'")
        }
        self.themes = try themeFiles.map { try configuration.type.init(file: $0, bundle: configuration.bundle) }
        let userDefaults = UserDefaults.standard
        if let identifier = userDefaults.string(forKey: Keys.currentTheme),
            let theme = self.themes.first(where: { $0.identifier == identifier }) {
            self.current = theme
        } else {
            self.current = themes[0]
        }
    }
}
