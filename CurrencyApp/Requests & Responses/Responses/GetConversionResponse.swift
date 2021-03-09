//
//  GetConversionResponse.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

class GetConversionResponse: BaseResponse {
    var conversion: ConversionResponse?
}

struct ConversionResponse: Decodable {
    var from: String?
    var to: String?
    var amount: Double?
    var result: Double?
}

//MARK: Transform
extension GetConversionResponse {
    var entity: Conversion {
        return Conversion(from: conversion?.from ?? "",
                          to: conversion?.to ?? "",
                          amount: conversion?.amount ?? 0,
                          result: conversion?.result ?? 0)
    }
}
