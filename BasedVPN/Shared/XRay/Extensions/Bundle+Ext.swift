//
//  Bundle+Ext.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import Foundation

extension Bundle {
    public static var appID: String {
        "co.uk.basedapps.vpn.BasedVPN"
    }

    public static var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
    }

    public static var providerBundleIdentifier: String {
        "co.uk.basedapps.vpn.v2ray-ne"
    }
}
