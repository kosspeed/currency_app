//
//  MockCurrencyResponseFactory.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

struct MockCurrencyResponseFactory {
    static var currenciesResponse: GetCurrenciesResponse {
        let response = MockGetCurrenciesResponse()
        response.valid = true
        response.updated = 12346
        response.currencies = [
            "THB": "Thai Baht",
            "USD": "US Dollar"
        ]
        
        return response
    }
    
    static var failure400Response: CurrencyErrorResponse {
        return MockCurrencyErrorResponseFactory.customErrorResponse(code: 400,
                                                                    message: "You did not supply an API key")
    }
    
    static var failure401Response: CurrencyErrorResponse {
        return MockCurrencyErrorResponseFactory.customErrorResponse(code: 401,
                                                                    message: "Your API key is not valid")
    }
    
    static var failure416Response: CurrencyErrorResponse {
        return MockCurrencyErrorResponseFactory.customErrorResponse(code: 416,
                                                                    message: "Your subscription plan does not allow you to use the %s endpoint")
    }
    
    static var ratesResponse: GetRatesResponse {
        let response = MockGetRatesResponse()
        response.valid = true
        response.updated = 12346
        response.base = "THB"
        response.rates = [
            "THB": 1.234,
            "USD": 34.0
        ]
        
        return response
    }
    
    static var conversionResponse: GetConversionResponse {
        let response = MockGetConversionResponse()
        response.valid = true
        response.updated = 12346
        response.conversion = MockConversionResponse(from: "THB",
                                                     to: "USD",
                                                     amount: 1.234,
                                                     result: 41.956)
        
        return response
    }
}

//MARK: Get Currencies
fileprivate class MockGetCurrenciesResponse: GetCurrenciesResponse {}

//MARK: Get Rates
fileprivate class MockGetRatesResponse: GetRatesResponse {}

//MARK: Get Conversion
fileprivate class MockGetConversionResponse: GetConversionResponse {}
fileprivate class MockConversionResponse: ConversionResponse {}
