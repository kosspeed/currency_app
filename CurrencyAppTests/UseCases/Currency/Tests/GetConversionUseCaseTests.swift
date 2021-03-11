//
//  GetConversionUseCaseTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class GetConversionUseCaseTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }
    
    func test_executeSuccess() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .success)
        let useCase = GetConversionUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(from: "THB", to: "USD", amount: 1.234, completion: { (conversion) in
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
    
    func test_executeFailure() {
        //arrange
        let repository = MockCurrencyRepositoryImpl(result: .failure)
        let useCase = GetConversionUseCaseImpl(repository: repository)
        
        //act
        useCase.execute(from: "", to: "", amount: 0, completion: { (conversion) in
           
        }, failure: { (error) in
            //assert
            XCTAssertEqual(error.detail.code, 9999)
            XCTAssertEqual(error.detail.message, "Default Error")
        })
    }
}
