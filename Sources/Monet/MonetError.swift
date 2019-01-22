//
//  MonetError.swift
//  Monet
//
//  Created by Benoit BRIATTE on 24/10/2017.
//  Copyright © 2017 Digipolitan. All rights reserved.
//

import Foundation

public enum MonetError: Error {
    case noSuchTheme(file: String)
    case malformatedTheme
    case noSuchAppearance(file: String)
    case malformatedAppearance
}
