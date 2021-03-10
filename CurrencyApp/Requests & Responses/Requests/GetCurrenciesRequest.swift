//
//  GetCurrenciesRequest.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetCurrenciesRequest: BaseRequest {}

//MARK: Transform
extension GetCurrenciesRequest {
    var urlParameters: [String: Any] {
        return [
            "key": key,
            "output": apiOutput
        ]
    }
}
