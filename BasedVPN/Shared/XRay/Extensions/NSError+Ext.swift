//
//  NSError+Ext.swift
//  BasedVPN
//
//  Created by Lika Vorobeva on 13.07.2023.
//

import Foundation

extension NSError {
    public static func newError(_ message: String) -> NSError {
        NSError(domain: "co.uk.basedapps.vpn", code: 0, userInfo: [NSLocalizedDescriptionKey: message])
    }
}
