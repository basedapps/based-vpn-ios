//
//  ErrorView.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 24.07.2023.
//

import SwiftUI

enum ErrorStateType {
    case empty
    case error(retry: () -> Void)
}

struct ErrorStateView: View {
    private let type: ErrorStateType

    init(type: ErrorStateType) {
        self.type = type
    }

    var body: some View {
        errorView
    }
}

// MARK: - ErrorStateView decomposition

extension ErrorStateView {
    @ViewBuilder
    private var errorView: some View {
        VStack(spacing: 12) {
            switch type {
            case .empty:
                Image(systemName: "eyes")
                    .resizable()
                    .foregroundColor(Colors.lightGrey.asColor.opacity(0.3))
                    .frame(width: 104, height: 81)
                    .padding(.vertical, 44)

                L10n.ErrorState.Empty.title.asText
                    .applyTextStyle(.systemGray(ofSize: 22, weight: .medium))
                L10n.ErrorState.Empty.description.asText
                    .applyTextStyle(.systemGray(ofSize: 16))
            case let .error(retry):
                Image(systemName: "bolt.horizontal.fill")
                    .resizable()
                    .foregroundColor(Colors.lightGrey.asColor.opacity(0.3))
                    .frame(width: 104, height: 47)
                    .padding(.vertical, 44)

                L10n.ErrorState.Failure.title.asText
                    .applyTextStyle(.systemGray(ofSize: 22, weight: .medium))
                L10n.ErrorState.Failure.description.asText
                    .applyTextStyle(.systemGray(ofSize: 16))

                Button(action: retry) {
                    L10n.ErrorState.Failure.button.asText
                        .applyTextStyle(.systemGray(ofSize: 15))
                        .padding()
                        .padding(.horizontal)
                        .background(Colors.neutralGray.asColor)
                        .cornerRadius(5)
                }
                .buttonStyle(.plain)
                .padding(.vertical, 30)
            }
        }
    }
}

// MARK: - Previews

struct ErrorStateView_Retry_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(type: .error(retry: {}))
    }
}

struct ErrorStateView_Empty_Previews: PreviewProvider {
    static var previews: some View {
        ErrorStateView(type: .empty)
    }
}

