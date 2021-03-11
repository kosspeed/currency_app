//
//  MockCurrencyRequestFactory.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

struct MockCurrencyRequestFactory {
    static var currenciesRequest: GetCurrenciesRequest {
        return MockGetCurrenciesRequest()
    }
    
    static var ratesRequest: GetRatesRequest {
        return MockGetRatesRequest()
    }
    
    static func getConversionRequest(from: String,
                                     to: String,
                                     amount: Double) -> GetConversionRequest {
        return MockGetConversionRequest(from: from,
                                        to: to,
                                        amount: amount)
    }
}

fileprivate var mockConfig: Config {
    return .init(type: .customize(baseURL: "https://test.test.net",
                                  apiToken: "123456789"))
}

//MARK: Get Currencies
fileprivate class MockGetCurrenciesRequest: GetCurrenciesRequest {
    override var config: Config {
        return mockConfig
    }
}

//MARK: Get Rates
fileprivate class MockGetRatesRequest: GetRatesRequest {
    override var config: Config {
        return mockConfig
    }
}

//MARK: Get Conversion
fileprivate class MockGetConversionRequest: GetConversionRequest {
    override var config: Config {
        return mockConfig
    }
}
