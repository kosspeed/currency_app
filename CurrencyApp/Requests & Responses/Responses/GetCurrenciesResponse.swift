//
//  GetCurrenciesResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetCurrenciesResponse: BaseResponse {
    var currencies: [String: Any]?
}

//MARK: Transform
extension GetCurrenciesResponse {
    var entity: Currency {
        let details: [CurrencyDetail] = currencies?.map {
            CurrencyDetail(name: $0.key, value: $0.value as? String ?? "")
        } ?? []
        
        return Currency(details: details)
    }
}
