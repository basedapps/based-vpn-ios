//  BasedVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import Foundation

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
