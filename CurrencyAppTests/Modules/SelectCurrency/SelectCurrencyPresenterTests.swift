//
//  SelectCurrencyPresenterTests.swift
//  CurrencyAppTests
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

@testable import CurrencyApp
import XCTest

class SelectCurrencyPresenterTests: XCTestCase {

    var sut: SelectCurrencyPresenter!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_presentGetCurrencies() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        /* Currencies */
        let currencies = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details

        /* Rates */
        let rates = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.presentGetCurrencies(response: .init(currencies: currencies,
                                                 rates: rates))
        
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel)
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel?.currencies)
        XCTAssert(displayableSpy.displayGetCurrenciesCalled)
    }
    
    func test_presentGetCurrenciesNilData() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        /* Currencies */
        var currencies = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
        
        for (index, _) in currencies.enumerated() {
            currencies[index].emoji = "Test"
            currencies[index].symbol = "Test"
        }

        /* Rates */
        var rates = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        for (index, _) in rates.enumerated() {
            rates[index].value = .nan
        }
        
        sut.presentGetCurrencies(response: .init(currencies: currencies,
                                                 rates: rates))
        
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel)
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel?.currencies)
        XCTAssert(displayableSpy.displayGetCurrenciesCalled)
    }
    
    func test_presentGetCurrenciesNilCurrencies() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        sut.presentGetCurrencies(response: .init(currencies: nil,
                                                 rates: nil))
        
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel)
        XCTAssertNotNil(displayableSpy.getCurrenciesViewModel?.currencies)
        XCTAssert(displayableSpy.displayGetCurrenciesCalled)
    }
    
    func test_presentSetSearchState() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        sut.presentSetSearchState(response: .init())
        
        XCTAssertNotNil(displayableSpy.setSearchStateViewModel)
        XCTAssert(displayableSpy.displaySetSearchStateCalled)
    }
    
    func test_presentSearch() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        /* Currencies */
        let currencies = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details

        /* Rates */
        let rates = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
        
        sut.presentSearch(response: .init(currencies: currencies,
                                                 rates: rates))
        
        XCTAssertNotNil(displayableSpy.searchViewModel)
        XCTAssertNotNil(displayableSpy.searchViewModel?.currencies)
        XCTAssert(displayableSpy.displaySearchCalled)
    }
    
    func test_queryCurrencyToExecute() {
        let displayableSpy = SelectCurrencyDisplayableSpy()
        
        sut = SelectCurrencyPresenter(displayable: displayableSpy)
        
        /* Currencies */
        let currency = MockCurrencyResponseFactory
            .currenciesResponse
            .entity
            .details
            .first ?? .init(name: "", value: "", symbol: nil, emoji: nil)

        /* Rates */
        let rate = MockCurrencyResponseFactory
            .ratesResponse
            .entity
            .details
            .first ?? .init(name: "", value: 0)
        
        sut.presentQueryCurrencyToExecute(response: .init(currency: currency, rate: rate))
        
        XCTAssertNotNil(displayableSpy.queryCurrencyToExecuteViewModel)
        XCTAssertNotNil(displayableSpy.queryCurrencyToExecuteViewModel?.currency)
        XCTAssertNotNil(displayableSpy.queryCurrencyToExecuteViewModel?.rate)
        XCTAssert(displayableSpy.displayQueryCurrencyToExecuteCalled)
    }
}

extension SelectCurrencyPresenterTests {
    class SelectCurrencyDisplayableSpy: SelectCurrencyDisplayable {
        var displayGetCurrenciesCalled = false
        var displaySetSearchStateCalled = false
        var displaySearchCalled = false
        var displayQueryCurrencyToExecuteCalled = false
        
        var getCurrenciesViewModel: SelectCurrency.GetCurrencies.ViewModel?
        var setSearchStateViewModel: SelectCurrency.SetSearchState.ViewModel?
        var searchViewModel: SelectCurrency.Search.ViewModel?
        var queryCurrencyToExecuteViewModel: SelectCurrency.QueryCurrencyToExecute.ViewModel?
        
        func displayGetCurrencies(viewModel: SelectCurrency.GetCurrencies.ViewModel) {
            displayGetCurrenciesCalled = true
            getCurrenciesViewModel = viewModel
        }
        
        func displaySetSearchState(viewModel: SelectCurrency.SetSearchState.ViewModel) {
            displaySetSearchStateCalled = true
            setSearchStateViewModel = viewModel
        }
        
        func displaySearch(viewModel: SelectCurrency.Search.ViewModel) {
            displaySearchCalled = true
            searchViewModel = viewModel
        }
        
        func displayQueryCurrencyToExecute(viewModel: SelectCurrency.QueryCurrencyToExecute.ViewModel) {
            displayQueryCurrencyToExecuteCalled = true
            queryCurrencyToExecuteViewModel = viewModel
        }
    }
}
