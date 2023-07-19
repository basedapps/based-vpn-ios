//
//  UIImpactFeedbackGenerator+Ext.swift
//  BaseVPN
//
//  Created by Victoria Kostyleva on 25.11.2021.
//

import UIKit

extension UIImpactFeedbackGenerator {
    static func lightFeedback() {
        UIImpactFeedbackGenerator().impactOccurred(intensity: 0.4)
    }
}
