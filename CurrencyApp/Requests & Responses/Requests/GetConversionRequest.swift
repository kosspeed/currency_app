//
//  GetConversionRequest.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetConversionRequest: BaseRequest {
    override var urlParametersJoined: String {
        return super.urlParametersJoined + "&from=\(from)&to=\(to)&amount=\(amount)"
    }
    
    var from: String
    var to: String
    var amount: Double

    init(from: String, to: String, amount: Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}
