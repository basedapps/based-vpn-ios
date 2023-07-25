//
//  UINavigationBarAppearance+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 25.07.2023.
//

import UIKit

extension UINavigationBarAppearance {
    func applyStyle() {
        configureWithTransparentBackground()
        largeTitleTextAttributes = [
            .foregroundColor: Colors.black.color,
            .font: FontFamily.DMSans.bold.font(size: 20)
        ]
        titleTextAttributes = [
            .foregroundColor: Colors.black.color,
            .font: FontFamily.DMSans.bold.font(size: 17)
        ]
        backgroundColor = Colors.black.color.withAlphaComponent(0.03)
        shadowColor = .clear
        UINavigationBar.appearance().scrollEdgeAppearance = self
        UINavigationBar.appearance().standardAppearance = self
    }
}
