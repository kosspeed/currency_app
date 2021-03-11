//
//  UIViewController+Extension.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 16/3/2564 BE.
//

import UIKit

extension UIViewController {
    func alert(with title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
