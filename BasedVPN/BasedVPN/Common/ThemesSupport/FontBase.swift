//
//  FontBase.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import UIKit

private let sizeFactor: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 5 : 0

extension TextStyle {
    enum FontBase {
        case system
        case dmSans
        
        func font(of weight: FontWeight, size: CGFloat) -> UIFont {
            let resized = size + sizeFactor
            switch self {
            case .system:
                return FontFamily.systemFont(from: weight, of: resized)
            case .dmSans:
                guard let font = FontFamily.DMSans.fontConvertible(from: weight)?.font(size: resized) else {
                    
                    log.warning("Unsupported SFCompactDisplay wanted! Returning regular.")
                    return FontFamily.DMSans.regular.font(size: resized)
                }
                return font
            }
        }
    }
}
