//
//  Rate.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation

struct Rate {
    var base: String
    var details: [RateDetail]
}

struct RateDetail {
    var name: String
    var value: Double
}
