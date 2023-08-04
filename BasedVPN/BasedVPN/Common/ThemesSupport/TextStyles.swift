//
//  TextStyles.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 29.11.2021.
//

import UIKit

private struct Constants {
    let defaultBase: TextStyle.FontBase = .dmSans
}

private let constants = Constants()

// MARK: - App-wide text styles

extension TextStyle {
    /// Black semibold of size 16
    static let title = TextStyle.black(ofSize: 17, weight: .bold)
}

// MARK: - Convinient functions for creation text styles

extension TextStyle {
    /// - Parameters:
    ///   - weight: Regular by default
    static func accent(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0,
        alpha: CGFloat = 1
    ) -> TextStyle {
        TextStyle(
            font: base.font(of: weight, size: size),
            color: Colors.accentBlue.color.withAlphaComponent(alpha),
            kern: kern
        )
    }

    /// - Parameters:
    ///   - weight: Medium by default
    static func white(
        ofSize size: CGFloat,
        weight: FontWeight = .medium,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.white.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func black(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0,
        alpha: CGFloat = 1
    ) -> TextStyle {
        TextStyle(
            font: base.font(of: weight, size: size),
            color: Colors.black.color.withAlphaComponent(alpha),
            kern: kern
        )
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func coral(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.coral.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func lightGrey(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.lightGrey.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func grey(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.grey.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func systemGray(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.systemGray.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func paleGrey(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.paleGrey.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func neutralGray(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.neutralGray.color, kern: kern)
    }

    /// - Parameters:
    ///   - weight: Regular by default
    static func mouseGrey(
        ofSize size: CGFloat,
        weight: FontWeight = .regular,
        base: FontBase = constants.defaultBase,
        kern: Double = 0
    ) -> TextStyle {
        TextStyle(font: base.font(of: weight, size: size), color: Colors.mouseGrey.color, kern: kern)
    }
}
