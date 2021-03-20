//
//  MockCurrencyErrorResponseFactory.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import Foundation

struct MockCurrencyErrorResponseFactory {
    static func customErrorResponse(code: Int = 9999, message: String = "Default Error") -> CurrencyErrorResponse {
        let response = MockCurrencyErrorResponse()
        response.valid = false
        response.error = MockCurrencyErrorDetailResponse(code: code, message: message)
        
        return response
    }
}

//MARK: Error
fileprivate class MockCurrencyErrorResponse: CurrencyErrorResponse {}
fileprivate class MockCurrencyErrorDetailResponse: CurrencyErrorDetailResponse {}
