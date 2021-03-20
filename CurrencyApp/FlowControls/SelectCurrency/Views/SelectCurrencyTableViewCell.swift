//
//  SelectCurrencyTableViewCell.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 20/3/2564 BE.
//

import UIKit

class SelectCurrencyTableViewCell: UITableViewCell {
    //MARK: IBOutlet
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var currencyCodeLabel: UILabel!
    @IBOutlet weak var currencyNameLabel: UILabel!
    @IBOutlet weak var currencySymbolLabel: UILabel!
    @IBOutlet weak var currencyRateLabel: UILabel!
    @IBOutlet weak var remarkLabel: UILabel!
    @IBOutlet weak var baseView: UIView!
    
    /* Static Properties */
    static var nibName: String {
        return "SelectCurrencyTableViewCell"
    }
    
    static var nib: UINib {
        return UINib(nibName: nibName, bundle: .main)
    }
    
    static var identifier: String {
        return "SelectCurrencyTableViewCellID"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
}

//MARK: Setup
private extension SelectCurrencyTableViewCell {
    func setup() {
        setupBaseView()
    }
    
    func setupBaseView() {
        baseView
            .layer
            .cornerRadius(radius: 8)
            .shadow(color: .black,
                    opacity: 0.3,
                    offset: .zero,
                    radius: 10)
    }
}

//MARK: Configure
extension SelectCurrencyTableViewCell {
    func configure(currency: SelectCurrency.Currency) {
        flagLabel.text = currency.flag
        flagLabel.font = UIFont.systemFont(ofSize: currency.flagFontSize,
                                           weight: .bold)
        
        currencyCodeLabel.text = currency.code
        currencyNameLabel.text = currency.name
        currencySymbolLabel.text = currency.symbol
        currencyRateLabel.text = currency.rate
    }
}
