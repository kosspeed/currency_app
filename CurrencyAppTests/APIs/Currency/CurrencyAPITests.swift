//
//  CurrencyAPITests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class CurrencyAPITests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_initialGetCurrenciesAPI() {
        //arrange
        let request = MockCurrencyRequestFactory.currenciesRequest
        let api = CurrencyAPI.getCurrencies(request: request)
        
        //assert
        XCTAssertNotNil(api.baseURL.absoluteString.contains("https://test.test.net"))
        XCTAssertNotNil(api.path)
        XCTAssertEqual(api.method, .get)
        XCTAssertNotNil(api.sampleData)
        XCTAssertNotNil(api.task)
        XCTAssertNil(api.headers)
    }
    
    func test_initialGetRatesAPI() {
        //arrange
        let request = MockCurrencyRequestFactory.ratesRequest
        let api = CurrencyAPI.getRates(request: request)
        
        //assert
        XCTAssertNotNil(api.baseURL.absoluteString.contains("https://test.test.net"))
        XCTAssertNotNil(api.path)
        XCTAssertEqual(api.method, .get)
        XCTAssertNotNil(api.sampleData)
        XCTAssertNotNil(api.task)
        XCTAssertNil(api.headers)
    }
    
    func test_initialGetConversionAPI() {
        //arrange
        let request = MockCurrencyRequestFactory.getConversionRequest(from: "",
                                                                      to: "",
                                                                      amount: 0)
        let api = CurrencyAPI.getConversion(request: request)
        
        //assert
        XCTAssertNotNil(api.baseURL.absoluteString.contains("https://test.test.net"))
        XCTAssertNotNil(api.path)
        XCTAssertEqual(api.method, .get)
        XCTAssertNotNil(api.sampleData)
        XCTAssertNotNil(api.task)
        XCTAssertNil(api.headers)
    }
}
