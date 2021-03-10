//
//  GetRatesResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetRatesResponse: BaseResponse {
    var base: String?
    var rates: [String: Any]?
}

//MARK: Transform
extension GetRatesResponse {
    var entity: Rate {
        let details: [RateDetail] = rates?.map {
            RateDetail(name: $0.key, value: $0.value as? Double ?? 0)
        } ?? []
        
        return Rate(base: base ?? "", details: details)
    }
}
