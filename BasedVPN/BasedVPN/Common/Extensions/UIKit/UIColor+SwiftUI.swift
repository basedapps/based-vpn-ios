//
//  UIColor+SwiftUI.swift
//  BaseVPN
//
//  Created by Victoria Kostyleva on 25.11.2021.
//

import UIKit
import SwiftUI

typealias Colors = Asset.Colors

extension UIColor {
    var asColor: Color {
        Color(self)
    }
}

extension ColorAsset {
    var asColor: SwiftUI.Color {
        SwiftUI.Color(color)
    }
}
