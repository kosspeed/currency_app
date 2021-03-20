//
//  BaseResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

protocol BaseResponse: Decodable {
    var valid: Bool? { get set }
    var updated: Int64? { get set }
}
