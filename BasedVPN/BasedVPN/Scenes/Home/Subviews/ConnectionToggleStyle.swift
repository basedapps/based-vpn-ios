//
//  ConnectionToggleStyle.swift
//  BagimsizVPN
//
//  Created by Lika Vorobeva on 27.09.2023.
//

import SwiftUI

// MARK: - ConnectionToggleStyle

struct ConnectionToggleStyle: ToggleStyle {
    @Binding var isLoading: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        RoundedRectangle(cornerRadius: 32)
            .fill(Colors.white.asColor)
            .frame(width: 119, height: 64, alignment: .center)
            .overlay(
                HStack {
                    if configuration.isOn {
                        Spacer()
                    }
                    
                    Image(systemName: "power")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(15)
                        .foregroundColor(
                            configuration.isOn && !isLoading ?
                            Colors.white.asColor : Colors.paleSalmon.asColor.opacity(0.4)
                        )
                        .background(
                            Circle().fill(configuration.isOn ? Colors.cherryRed.asColor : Colors.coral.asColor)
                        )
                        .shadow(color: Colors.black.asColor.opacity(0.2), radius: 5)
                        .padding(.horizontal, 5)
                        .gesture(
                            DragGesture()
                                .onEnded { _ in
                                    configuration.isOn.toggle() }
                        )
                    
                    if !configuration.isOn {
                        Spacer()
                    }
                }
                    .environment(\.layoutDirection, .leftToRight)
            )
            .shadow(color: Colors.black.asColor.opacity(0.1), radius: 5)
            .onTapGesture { configuration.isOn.toggle() }
    }
}

// MARK: - Previews

struct ConnectionToggleStyleView: View {
    @State private var showGreeting = true
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Toggle("", isOn: $showGreeting)
                    .labelsHidden()
                    .toggleStyle(ConnectionToggleStyle(isLoading: $isLoading))
                Spacer()
            }
            Spacer()
        }
        .background(Colors.whitish.color.asColor)
    }
}

struct ConnectionToggleStyleView_Previews: PreviewProvider {
    static var previews: some View {
        ConnectionToggleStyleView()
    }
}
