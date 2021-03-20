//
//  BaseRequest.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class BaseRequest: RequestConfigable, Requestable {
    var config: Config {
        return .default
    }
    
    var key: String {
        return config.apiToken
    }
    
    var apiOutput: String {
        return Constants.APIOutput.json.rawValue
    }
    
    var urlParameters: [String: Any] {
        return [
            "key": key,
            "output": apiOutput
        ]
    }
}
