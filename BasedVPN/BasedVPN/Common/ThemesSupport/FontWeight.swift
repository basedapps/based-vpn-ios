//
//  FontWeight.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 13.04.2022.
//

import UIKit

// MARK: - FontWeight

enum FontWeight {
    case regular
    case medium
    case italic
    
    case bold
    case semibold
    
    case black
    case heavy
    
    case light
    case thin
    case ultralight
}

// MARK: - DMSans

extension FontFamily.DMSans {
    static func fontConvertible(from fontWeight: FontWeight) -> FontConvertible? {
        let baseFont = FontFamily.DMSans.self
        switch fontWeight {
        case .regular:
            return baseFont.regular
        case .black:
            return baseFont.black
        case .bold:
            return baseFont.bold
        case .heavy:
            return nil
        case .light:
            return baseFont.light
        case .medium:
            return baseFont.medium
        case .semibold:
            return baseFont.semiBold
        case .thin:
            return baseFont.thin
        case .ultralight:
            return baseFont.extraLight
        case .italic:
            return baseFont.italic
        }
    }
}

// MARK: - SFPro

extension FontFamily {
    static func systemFont(from fontWeight: FontWeight = .regular, of size: CGFloat = 15) -> UIFont {
        switch fontWeight {
        case .regular:
            return .systemFont(ofSize: size)
        case .medium:
            return .systemFont(ofSize: size, weight: .medium)
        case .italic:
            return .italicSystemFont(ofSize: size)
        case .light:
            return .systemFont(ofSize: size, weight: .light)
        case .bold:
            return .boldSystemFont(ofSize: size)
        case .semibold:
            return .systemFont(ofSize: size, weight: .semibold)
        case .black:
            return .systemFont(ofSize: size, weight: .black)
        case .heavy:
            return .systemFont(ofSize: size, weight: .heavy)
        case .thin:
            return .systemFont(ofSize: size, weight: .thin)
        case .ultralight:
            return .systemFont(ofSize: size, weight: .ultraLight)
        }
    }
}
