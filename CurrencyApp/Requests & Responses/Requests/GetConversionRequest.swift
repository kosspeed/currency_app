//
//  GetConversionRequest.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetConversionRequest: BaseRequest {
    var from: String
    var to: String
    var amount: Double
    
    init(from: String, to: String, amount: Double) {
        self.from = from
        self.to = to
        self.amount = amount
    }
}

//MARK: Transform
extension GetConversionRequest {
    var urlParameters: [String: Any] {
        return [
            "key": key,
            "output": apiOutput,
            "from": from,
            "to": to,
            "amount": amount
        ]
    }
}
