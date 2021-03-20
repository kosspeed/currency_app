//
//  GetRatesResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetRatesResponse: BaseResponse {
    var valid: Bool?
    var updated: Int64?
    var base: String?
    var rates: [String: Double]?
}

//MARK: Transform
extension GetRatesResponse {
    var entity: Rate {
        let details: [RateDetail] = rates?.map {
            RateDetail(name: $0.key, value: $0.value)
        } ?? []
        
        return Rate(base: base ?? "", details: details)
    }
}
