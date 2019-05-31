//
//  Monet.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import UIKit

public extension Notification.Name {
    static let MonetThemeDidChange = Notification.Name("MonetThemeDidChange")
}

public class Monet {

    public enum Alias {
        public static let colors = "@colors"
        public static let fonts = "@fonts"
    }

    public static let shared = Monet()

    public var theme: Theme? {
        didSet {
            NotificationCenter.default.post(name: Notification.Name.MonetThemeDidChange, object: self.theme)
        }
    }
}
