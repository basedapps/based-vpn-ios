//
//  Toast.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 18.07.2023.
//

import SwiftUI

struct Toast: ViewModifier {
    private let message: String
    private let config: Config

    @Binding var isShowing: Bool

    init(message: String, config: Config, isShowing: Binding<Bool>) {
        self.message = message
        self.config = config
        self._isShowing = isShowing
    }

    func body(content: Content) -> some View {
        ZStack {
            content
            toastView
        }
    }
}

extension Toast {
    private var toastView: some View {
        VStack {
            message
                .asText
                .applyTextStyle(config.textStyle)
                .multilineTextAlignment(.center)
                .padding(8)
                .background(config.backgroundColor)
                .cornerRadius(8)
                .frame(maxWidth: 250)
                .onTapGesture { isShowing = false }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + config.duration) {
                        isShowing = false
                    }
                }
                .isHidden(!isShowing)

            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.top, 18)
        .animation(config.animation, value: isShowing)
        .transition(config.transition)
    }
}

// MARK: - Config

extension Toast {
    struct Config {
        static let short: TimeInterval = 3
        static let long: TimeInterval = 5

        let textStyle: TextStyle
        let backgroundColor: Color
        let duration: TimeInterval
        let transition: AnyTransition
        let animation: Animation

        init(
            textStyle: TextStyle = .white(ofSize: 14),
            backgroundColor: Color = .black.opacity(0.6),
            duration: TimeInterval = Config.short,
            transition: AnyTransition = .opacity,
            animation: Animation = .linear(duration: 0.3)
        ) {
            self.textStyle = textStyle
            self.backgroundColor = backgroundColor
            self.duration = duration
            self.transition = transition
            self.animation = animation
        }
    }

    enum Style {
        case error
        case info

        var config: Config {
            switch self {
            case .error:
                return .init(backgroundColor: Colors.coral.asColor)
            case .info:
                return  .init(backgroundColor: Colors.accentBlue.asColor)
            }
        }
    }
}
