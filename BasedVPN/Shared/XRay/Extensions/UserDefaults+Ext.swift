//
//  UserDefaults+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import Foundation

extension UserDefaults {
    public static let shared: UserDefaults = UserDefaults(suiteName: XConstant.suiteName)!
}
