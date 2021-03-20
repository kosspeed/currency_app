//
//  SelectCurrencyViewController.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//  Copyright (c) 2564 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class SelectCurrencyViewController: UIViewController {
    //MARK: @IBOutlet
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    /* Static Properties */
    private static var storyboardName: String {
        return "SelectCurrency"
    }
    
    private static var storyboard: UIStoryboard {
        return UIStoryboard(name: storyboardName, bundle: .main)
    }
    
    static var identifier: String {
        return "SelectCurrencyViewControllerID"
    }
    
    //MARK: VIP Cycle
    var interactor: SelectCurrencyBusinessLogic!
    var router: (SelectCurrencyRoutable & SelectCurrencyDataPassing)!
    
    private var currencies: [SelectCurrency.Currency]?
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    static func make() -> SelectCurrencyViewController {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! SelectCurrencyViewController
    }
    
    //MARK: IBAction
    @IBAction func backButtonTapped(_ sender: Any) {
        back()
    }
}

//MARK: Setup & Configuration
extension SelectCurrencyViewController {
    private func setup() {
        setupTableView()
        setupSearchBar()
        getCurrencies()
    }
    
    private func configure() {
        let viewController = self
        let router = SelectCurrencyRouter(viewController: viewController)
        let presenter = SelectCurrencyPresenter(displayable: viewController)
        let interactor = SelectCurrencyInteractor(presenter: presenter)
        
        viewController.interactor = interactor
        viewController.router = router
        viewController.router.dataStore = interactor
    }
    
    private func setupTableView() {
        tableView.register(SelectCurrencyTableViewCell.nib,
                           forCellReuseIdentifier: SelectCurrencyTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupSearchBar() {
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }
}

//MARK: UITableViewDataSource & UITableViewDelegate
extension SelectCurrencyViewController: UITableViewDataSource & UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SelectCurrencyTableViewCell.identifier, for: indexPath) as? SelectCurrencyTableViewCell else {
            return UITableViewCell()
        }
        
        guard let currency = currencies?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(currency: currency)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let currency = currencies?[indexPath.row] else {
            return
        }
        
        queryCurrencyToExecute(code: currency.code ?? "")
    }
}

//MARK: UISearchBarDelegate
extension SelectCurrencyViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        setSearchState(searching: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        setSearchState(searching: false)
        getCurrencies()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        setSearchState(searching: !searchText.isEmpty)
        search(text: searchText)
    }
}

//MARK: Logics
private extension SelectCurrencyViewController {
    func getCurrencies() {
        interactor.getCurrencies(request: .init())
    }
    
    func setSearchState(searching: Bool) {
        interactor.setSearchState(request: .init(searching: searching))
    }
    
    func search(text: String) {
        interactor.search(request: .init(text: text))
    }
    
    func queryCurrencyToExecute(code: String) {
        interactor.queryCurrencyToExecute(request: .init(code: code))
    }
    
    func back() {
        router.routeBack()
    }
    
    func execute(currency: CurrencyDetail, rate: RateDetail) {
        router.execute(currency: currency, rate: rate)
    }
}

//MARK: Displayable
extension SelectCurrencyViewController: SelectCurrencyDisplayable {
    func displayGetCurrencies(viewModel: SelectCurrency.GetCurrencies.ViewModel) {
        currencies = viewModel.currencies
        tableView.reloadData()
    }
    
    func displaySetSearchState(viewModel: SelectCurrency.SetSearchState.ViewModel) {
        
    }
    
    func displaySearch(viewModel: SelectCurrency.Search.ViewModel) {
        currencies = viewModel.currencies
        tableView.reloadData()
    }
    
    func displayQueryCurrencyToExecute(viewModel: SelectCurrency.QueryCurrencyToExecute.ViewModel) {
        execute(currency: viewModel.currency, rate: viewModel.rate)
        back()
    }
}

