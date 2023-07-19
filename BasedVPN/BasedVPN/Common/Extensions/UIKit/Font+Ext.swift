//
//  Font+Ext.swift
//  SOLAR dVPN
//
//  Created by Lika Vorobeva on 29.11.2021.
//

import SwiftUI

extension UIFont {
    var asSwiftUIFont: SwiftUI.Font {
        SwiftUI.Font(self as CTFont)
    }
}
