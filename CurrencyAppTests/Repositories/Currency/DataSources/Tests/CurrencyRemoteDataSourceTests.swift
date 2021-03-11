//
//  CurrencyRemoteDataSourceTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest
import Moya

class CurrencyRemoteDataSourceTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_callGetCurrenciesAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "get_currencies_success", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            /*
             currencies = [
                 "THB": "Thai Baht",
                 "USD": "US Dollar"
             ]
             */
            
            //assert
            XCTAssertTrue(currency.details.contains(where: { $0.name == "THB" }))
            XCTAssertTrue(currency.details.contains(where: { $0.value == "Thai Baht" }))
            XCTAssertTrue(currency.details.contains(where: { $0.name == "USD" }))
            XCTAssertTrue(currency.details.contains(where: { $0.value == "US Dollar" }))
            
        }, failure: { (error) in
            
        })
    }
    
    func test_callGetCurrenciesAPIFailure() {
        //arrange
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkError(.init(domain: "", code: 9999, userInfo: nil)))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
        })
    }
    
    func test_callGetRatesAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "get_rates_success", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getRates(request: MockCurrencyRequestFactory.ratesRequest, completion: { (rates) in
            /*
             base = "THB"
             rates = [
                 "THB": 1.234,
                 "USD": 34.0
             ]
             */
            
            //assert
            XCTAssertEqual(rates.base, "THB")
            XCTAssertTrue(rates.details.contains(where: { $0.name == "THB" }))
            XCTAssertTrue(rates.details.contains(where: { $0.value == 1.234 }))
            XCTAssertTrue(rates.details.contains(where: { $0.name == "USD" }))
            XCTAssertTrue(rates.details.contains(where: { $0.value == 34.0 }))
            
        }, failure: { (error) in
            
        })
    }
    
    func test_callGetRatesAPIFailure() {
        //arrange
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkError(.init(domain: "", code: 9999, userInfo: nil)))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getRates(request: MockCurrencyRequestFactory.ratesRequest, completion: { (rates) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
        })
    }
    
    func test_callGetConversionAPISuccess() {
        //arrange
        guard let data = Bundle.loadDataInJSONFile(fileName: "get_conversion_success", type: type(of: self)) else {
            XCTFail()
            
            return
        }
        
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkResponse(200, data))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getConversion(request: MockCurrencyRequestFactory.getConversionRequest(from: "THB", to: "USD", amount: 1.234), completion: { (conversion) in
            
            /*
             from = "THB"
             to = "USD",
             amount = 1.234
             result = 41.956
             */
            
            //assert
            XCTAssertEqual(conversion.from, "THB")
            XCTAssertEqual(conversion.to, "USD")
            XCTAssertEqual(conversion.amount, 1.234)
            XCTAssertEqual(conversion.result, 41.956)
            
        }, failure: { (error) in
            
        })
    }
    
    func test_callGetConversionAPIFailure() {
        //arrange
        let provider = MoyaProvider<CurrencyAPI>(endpointClosure: { $0.endpointForAPI(response: .networkError(.init(domain: "", code: 9999, userInfo: nil)))
        }, stubClosure: { _ in
            .immediate
        })
        
        let remoteDataSource = CurrencyRemoteDataSourceImpl(provider: provider)
        
        //act
        remoteDataSource.getConversion(request: MockCurrencyRequestFactory.getConversionRequest(from: "", to: "", amount: 0), completion: { (conversion) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
        })
    }
}
