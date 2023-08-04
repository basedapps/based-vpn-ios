//
//  ImageAsset+Ext.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 02.12.2021.
//

import SwiftUI

extension ImageAsset {
    var asImage: SwiftUI.Image {
        SwiftUI.Image(uiImage: self.image)
    }
}
