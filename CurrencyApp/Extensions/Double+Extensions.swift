//
//  Double+Extensions.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//

import Foundation

extension Double {
    mutating func roundToPlaces(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    var commas: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
