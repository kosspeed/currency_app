//
//  Requestable.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

protocol Requestable: Encodable {
    var key: String { get }
    var apiOutput: String { get }
    var urlParameters: [String: Any] { get }
}
