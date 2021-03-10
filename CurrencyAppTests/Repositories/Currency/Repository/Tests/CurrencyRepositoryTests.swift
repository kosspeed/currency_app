//
//  CurrencyRepositoryTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class CurrencyRepositoryTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_getCurrenciesSuccess() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .success)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
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
    
    func test_getCurrenciesFailure() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
    
    func test_getCurrenciesFailure400() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure400)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 400)
            XCTAssertEqual(error.detail.message, "You did not supply an API key")
        })
    }
    
    func test_getCurrenciesFailure401() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure401)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 401)
            XCTAssertEqual(error.detail.message, "Your API key is not valid")
        })
    }
    
    func test_getCurrenciesFailure416() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure416)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getCurrencies(request: MockCurrencyRequestFactory.currenciesRequest, completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 416)
            XCTAssertEqual(error.detail.message, "Your subscription plan does not allow you to use the %s endpoint")
        })
    }
    
    func test_getRatesSuccess() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .success)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getRates(request: MockCurrencyRequestFactory.ratesRequest, completion: { (rates) in
            
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
    
    func test_getRatesFailure() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getRates(request: MockCurrencyRequestFactory.ratesRequest, completion: { (rates) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
    
    func test_getConversionSuccess() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .success)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getConversion(request: MockCurrencyRequestFactory.getConversionRequest(from: "THB", to: "USD", amount: 1.234), completion: { (conversion) in
            
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
    
    func test_getConversionFailure() {
        //arrange
        let remoteDataSource = MockCurrencyRemoteDataSourceImpl(result: .failure)
        let repository = CurrencyRepositoryImpl(remoteDataSource: remoteDataSource)
        
        //act
        repository.getConversion(request: MockCurrencyRequestFactory.getConversionRequest(from: "", to: "", amount: 0.0), completion: { (rates) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
}
