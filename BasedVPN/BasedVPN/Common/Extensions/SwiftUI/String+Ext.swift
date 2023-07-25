//
//  String+Ext.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 02.03.2023.
//

import SwiftUI

extension String {
    var asText: Text {
        Text(self)
    }
}

extension String {
    func splitToArray(separator: Character = ",", trimmingCharacters: CharacterSet? = nil) -> [String] {
        split(separator: separator)
            .map {
                guard let charSet = trimmingCharacters else { return String($0) }
                return $0.trimmingCharacters(in: charSet)
            }
    }
}

extension Optional where Wrapped == String {
    func splitToArray(separator: Character = ",", trimmingCharacters: CharacterSet? = nil) -> [String] {
        self?.splitToArray(separator: separator, trimmingCharacters: trimmingCharacters) ?? []
    }
}
