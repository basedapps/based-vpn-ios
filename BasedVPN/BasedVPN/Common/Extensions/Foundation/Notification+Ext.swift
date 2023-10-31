//
//  Notification+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 30.10.2023.
//

import Foundation

extension Notification.Name {
    static let banned = Self("device.isBanned")
    static let unenrolled = Self("device.isUnenrolled")
}
