//
//  GetCurrenciesUseCaseTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class GetCurrenciesUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .success)
        let useCase = GetCurrenciesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (currency) in
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
    
    func test_executeFailure() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure)
        let useCase = GetCurrenciesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (currency) in
           
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
    
    func test_executeFailure400() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure400)
        let useCase = GetCurrenciesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 400)
            XCTAssertEqual(error.detail.message, "You did not supply an API key")
        })
    }
    
    func test_executeFailure401() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure401)
        let useCase = GetCurrenciesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 401)
            XCTAssertEqual(error.detail.message, "Your API key is not valid")
        })
    }
    
    func test_executeFailure416() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure416)
        let useCase = GetCurrenciesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (currency) in
            
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 416)
            XCTAssertEqual(error.detail.message, "Your subscription plan does not allow you to use the %s endpoint")
        })
    }
}
