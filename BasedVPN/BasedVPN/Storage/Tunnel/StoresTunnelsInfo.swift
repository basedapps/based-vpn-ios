//
//  StoresTunnelsInfo.swift
//  BaseVPN
//
//  Created by Lika Vorobeva on 13.10.2021.
//

import Foundation

protocol StoresTunnelsInfo {
    var selectedDNS: DNSServerType { get set }
    var city: City? { get set }
}
