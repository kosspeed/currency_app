//
//  MainPageViewController.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 11/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet private weak var currencyTopView: UIView!
    @IBOutlet private weak var currencySymbolTopLabel: UILabel!
    @IBOutlet private weak var currencyCodeTopLabel: UILabel!
    @IBOutlet private weak var currencyNameTopLabel: UILabel!
    @IBOutlet private weak var currencyAmountTopTextField: UITextField!
    
    @IBOutlet private weak var switchButton: UIButton!
    
    @IBOutlet private weak var currencyBottomView: UIView!
    @IBOutlet private weak var currencySymbolBottomLabel: UILabel!
    @IBOutlet private weak var currencyCodeBottomLabel: UILabel!
    @IBOutlet private weak var currencyNameBottomLabel: UILabel!
    @IBOutlet private weak var currencyAmountBottomLabel: UILabel!
    
    //MARK: Properties
    private var textFieldTimer: Timer?
    
    //MARK: VIP Cycle
    var interactor: MainPageBusinessLogic!
    var router: (MainPageRoutable & MainPageDataPassing)!
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getCurrencies()
    }
    
    //MARK: IBAction
    @IBAction func changeCurrencyTopButtonTapped(_ sender: Any) {
        routeToCurrencySelection()
    }
    
    @IBAction func changeCurrencyBottomButtonTapped(_ sender: Any) {
        routeToCurrencySelection()
    }
    
    @IBAction func switchButtonTapped(_ sender: Any) {
        switchCurrency()
    }
    
    @IBAction func convertButtonDidTapped(_ sender: Any) {
        getConversion(text: currencyAmountTopTextField.text)
    }
}

//MARK: Setup & Configuration
extension MainPageViewController {
    private func configure() {
        let viewController = self
        let router = MainPageRouter(viewController: viewController)
        let presenter = MainPagePresenter(displayable: viewController)
        let interactor = MainPageInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.router.dataStore = interactor
    }
    
    private func setup() {
        setupCurrencyView()
        setupCurrencyAmountTopTextField()
    }
    
    private func setupCurrencyView() {
        currencyTopView
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
        
        currencyBottomView
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
    }
    
    private func setupCurrencyAmountTopTextField() {
        currencyAmountTopTextField.delegate = self
    }
}

//MARK: Logics
private extension MainPageViewController {
    func getCurrencies() {
        interactor.getCurrencies(request: .init())
    }
    
    func getRates() {
        interactor.getRates(request: .init())
    }
    
    func getConversion(text: String?) {
        interactor.getConversion(request: .init(amount: text ?? ""))
    }
    
    func switchCurrency() {
        interactor.switchCurrency(request: .init())
    }
    
    func routeToCurrencySelection() {
        router.routeToCurrencySelection()
    }
}

//MARK: Displayable
extension MainPageViewController: MainPageDisplayable {
    func displayGetCurrencies(viewModel: MainPage.GetCurrencies.ViewModel) {
        setCurrencyUI(with: viewModel.top, and: viewModel.bottom)
        
        getRates()
    }
    
    func displayGetRates(viewModel: MainPage.GetRates.ViewModel) {
        
    }
    
    func displayGetConversion(viewModel: MainPage.GetConversion.ViewModel) {
        currencyAmountBottomLabel.text = viewModel.amount
    }
    
    func displaySwitchCurrency(viewModel: MainPage.SwitchCurrency.ViewModel) {
        setCurrencyUI(with: viewModel.top, and: viewModel.bottom)
    }
    
    func displayError(viewModel: MainPage.Error.ViewModel) {
        alert(with: "Error", message: viewModel.message)
    }
    
    private func setCurrencyUI(with topCard: MainPage.CurrencyCard, and bottomCard: MainPage.CurrencyCard) {
        /* Top */
        currencySymbolTopLabel.text = topCard.symbol
        currencyCodeTopLabel.text = topCard.code
        currencyNameTopLabel.text = topCard.name
        
        /* Bottom */
        currencySymbolBottomLabel.text = bottomCard.symbol
        currencyCodeBottomLabel.text = bottomCard.code
        currencyNameBottomLabel.text = bottomCard.name
    }
}

//MARK: UITextFieldDelegate
extension MainPageViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField == currencyAmountTopTextField {
            currencyAmountBottomLabel.text = nil
        }
        
        return true
    }
}
