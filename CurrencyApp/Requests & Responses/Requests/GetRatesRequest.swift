//
//  GetRatesRequest.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetRatesRequest: BaseRequest {}

//MARK: Transform
extension GetRatesRequest {
    var urlParameters: [String: Any] {
        return [
            "key": key,
            "output": apiOutput
        ]
    }
}
