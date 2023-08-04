//
//  DisclosureGroupSectionItem.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 25.07.2023.
//

import SwiftUI

typealias SelectionType = Hashable & CustomStringConvertible

struct DisclosureGroupSectionItem<Selection: SelectionType>: View {
    @Binding private var isExpanded: Bool
    @Binding private var selection: Selection

    private let title: String
    private let cases: [Selection]

    init(title: String, cases: [Selection], selection: Binding<Selection>, isExpanded: Binding<Bool>) {
        self.title = title
        self.cases = cases
        self._isExpanded = isExpanded
        self._selection = selection
    }

    var body: some View {
        disclosureGroup
            .alignmentGuide(.listRowSeparatorLeading) { _ in
                return -10
            }
            .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}

extension DisclosureGroupSectionItem {
    private var disclosureGroup: some View {
        DisclosureGroup(
            isExpanded: $isExpanded,
            content: { pickerView },
            label: { buttonView }
        )
        .buttonStyle(.plain)
    }

    private var pickerView: some View {
        Picker("", selection: $selection) {
            ForEach(cases, id: \.self) {
                $0.description.asText
                    .applyTextStyle(.black(ofSize: 12, weight: .light))
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 80)
    }

    private var buttonView: some View {
        HStack {
           title.asText
                .applyTextStyle(.black(ofSize: 17))

            Spacer()

            selection.description.asText
                .applyTextStyle(.mouseGrey(ofSize: 17))
        }
        .padding(.vertical, 12)
    }
}
