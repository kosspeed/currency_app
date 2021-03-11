//
//  GetCurrenciesResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetCurrenciesResponse: BaseResponse {
    var valid: Bool?
    var updated: Int64?
    var currencies: [String: String]?
}

//MARK: Transform
extension GetCurrenciesResponse {
    var entity: Currency {
        let details: [CurrencyDetail] = currencies?.map {
            CurrencyDetail(name: $0.key, value: $0.value)
        } ?? []
        
        return Currency(details: details)
    }
}
