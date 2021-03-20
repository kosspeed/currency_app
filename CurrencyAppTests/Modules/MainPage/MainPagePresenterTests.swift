//
//  MainPagePresenterTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class MainPagePresenterTests: XCTestCase {

    var sut: MainPagePresenter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_presentGetCurrencies() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        let topCurrency = currencyDetails[0]
        let bottomCurrency = currencyDetails[1]
        
        sut.presentGetCurrencies(response: .init(top: topCurrency, bottom: bottomCurrency))
        
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel)
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel?.top)
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel?.bottom)
        XCTAssert(displayableSpy.displayGetCurrenciesCalled)
    }
    
    func test_presentGetRates() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        sut.presentGetRates(response: .init())
        
        XCTAssertNotNil(displayableSpy.getRatesViewModel)
        XCTAssert(displayableSpy.displayGetRatesCalled)
    }
    
    func test_presentGetConversion() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        sut.presentGetConversion(response: .init(result: 1234))
        
        XCTAssertNotNil(displayableSpy.getConversionViewModel)
        XCTAssertNotNil(displayableSpy.getConversionViewModel?.amount)
        XCTAssert(displayableSpy.displayGetConversionCalled)
    }
    
    func test_presentSwitchCurrency() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        let topCurrency = currencyDetails[0]
        let bottomCurrency = currencyDetails[1]
        
        sut.presentSwitchCurrency(response: .init(top: topCurrency, bottom: bottomCurrency))
        
        XCTAssertNotNil(displayableSpy.switchCurrencyViewModel)
        XCTAssertNotNil(displayableSpy.switchCurrencyViewModel?.top)
        XCTAssertNotNil(displayableSpy.switchCurrencyViewModel?.bottom)
        XCTAssert(displayableSpy.displaySwitchCurrencyCalled)
    }
    
    func test_presentSetCurrency() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        let currencyDetails = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        let topCurrency = currencyDetails[0]
        let bottomCurrency = currencyDetails[1]
        
        sut.presentSetCurrency(response: .init(top: topCurrency, bottom: bottomCurrency))
        
        XCTAssertNotNil(displayableSpy.setCurrencyViewModel)
        XCTAssertNotNil(displayableSpy.setCurrencyViewModel?.top)
        XCTAssertNotNil(displayableSpy.setCurrencyViewModel?.bottom)
        XCTAssert(displayableSpy.displaySetCurrencyCalled)
    }
    
    func test_presentSetToken() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        sut.presentSetToken(response: .init())
        
        XCTAssertNotNil(displayableSpy.setTokenViewModel)
        XCTAssert(displayableSpy.displaySetTokenCalled)
    }
    
    func test_presentError() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        let error = MockCurrencyErrorResponseFactory
            .customErrorResponse(code: .zero, message: "")
            .entity
        
        sut.presentError(response: .init(error: error))
        
        XCTAssertNotNil(displayableSpy.errorViewModel)
        XCTAssertNotNil(displayableSpy.errorViewModel?.code)
        XCTAssertNotNil(displayableSpy.errorViewModel?.message)
        XCTAssertNotNil(displayableSpy.errorViewModel?.type)
        XCTAssert(displayableSpy.displayErrorCalled)
    }
    
    func test_presentError9999() {
        let displayableSpy = MainPageDisplayableSpy()
        
        sut = MainPagePresenter(displayable: displayableSpy)
        
        let error = MockCurrencyErrorResponseFactory
            .customErrorResponse(code: 9999, message: "")
            .entity
        
        sut.presentError(response: .init(error: error))
        
        XCTAssertNotNil(displayableSpy.errorViewModel)
        XCTAssertNotNil(displayableSpy.errorViewModel?.code)
        XCTAssertNotNil(displayableSpy.errorViewModel?.message)
        XCTAssertNotNil(displayableSpy.errorViewModel?.type)
        XCTAssert(displayableSpy.displayErrorCalled)
    }
}

extension MainPagePresenterTests {
    class MainPageDisplayableSpy: MainPageDisplayable {
        var displayGetCurrenciesCalled = false
        var displayGetRatesCalled = false
        var displayGetConversionCalled = false
        var displaySwitchCurrencyCalled = false
        var displaySetCurrencyCalled = false
        var displaySetTokenCalled = false
        var displayErrorCalled = false
        
        var getCurrenciesViewModel: MainPage.GetCurrencies.ViewModel?
        var getRatesViewModel: MainPage.GetRates.ViewModel?
        var getConversionViewModel: MainPage.GetConversion.ViewModel?
        var switchCurrencyViewModel: MainPage.SwitchCurrency.ViewModel?
        var setCurrencyViewModel: MainPage.SetCurrency.ViewModel?
        var setTokenViewModel: MainPage.SetToken.ViewModel?
        var errorViewModel: MainPage.Error.ViewModel?
        
        func displayGetCurrencies(viewModel: MainPage.GetCurrencies.ViewModel) {
            displayGetCurrenciesCalled = true
            getCurrenciesViewModel = viewModel
        }
        
        func displayGetRates(viewModel: MainPage.GetRates.ViewModel) {
            displayGetRatesCalled = true
            getRatesViewModel = viewModel
        }
        
        func displayGetConversion(viewModel: MainPage.GetConversion.ViewModel) {
            displayGetConversionCalled = true
            getConversionViewModel = viewModel
        }
        
        func displaySwitchCurrency(viewModel: MainPage.SwitchCurrency.ViewModel) {
            displaySwitchCurrencyCalled = true
            switchCurrencyViewModel = viewModel
        }
        
        func displaySetCurrency(viewModel: MainPage.SetCurrency.ViewModel) {
            displaySetCurrencyCalled = true
            setCurrencyViewModel = viewModel
        }
        
        func displaySetToken(viewModel: MainPage.SetToken.ViewModel) {
            displaySetTokenCalled = true
            setTokenViewModel = viewModel
        }
        
        func displayError(viewModel: MainPage.Error.ViewModel) {
            displayErrorCalled = true
            errorViewModel = viewModel
        }
    }
}
