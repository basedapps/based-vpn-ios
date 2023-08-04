//
//  View+Ext.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 05.12.2021.
//

import SwiftUI

// MARK: - Toast

extension View {
    func toast(message: String, isShowing: Binding<Bool>, type: Toast.Style = .error) -> some View {
        self.modifier(Toast(message: message, config: type.config, isShowing: isShowing))
    }
}

// MARK: - isHidden

extension View {
    @ViewBuilder func isHidden(_ hidden: Bool, remove: Bool = false) -> some View {
        if hidden {
            if !remove {
                self.hidden()
            }
        } else {
            self
        }
    }
}

// MARK: - RoundedCorner

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
