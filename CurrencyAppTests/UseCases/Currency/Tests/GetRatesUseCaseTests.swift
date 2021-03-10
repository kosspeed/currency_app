//
//  GetRatesUseCaseTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class GetRatesUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .success)
        let useCase = GetRatesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (rates) in
            
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
    
    func test_executeFailure() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure)
        let useCase = GetRatesUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(completion: { (rates) in
           
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
}
