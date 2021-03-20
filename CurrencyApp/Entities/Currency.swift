//
//  Currency.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

struct Currency {
    var details: [CurrencyDetail]
}

struct CurrencyDetail {
    var name: String
    var value: String
    var symbol: String?
    var emoji: String?
}
