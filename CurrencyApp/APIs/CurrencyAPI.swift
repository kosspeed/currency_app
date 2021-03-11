//
//  CurrencyAPI.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 10/3/2564 BE.
//

import Foundation
import Moya

enum CurrencyAPI {
    case getCurrencies(request: GetCurrenciesRequest)
    case getRates(request: GetRatesRequest)
    case getConversion(request: GetConversionRequest)
}

//MARK: TargetType
extension CurrencyAPI: TargetType {
    var baseURL: URL {
        let config: Config
        
        switch self {
        case .getCurrencies(let request):
            config = request.config
        case .getRates(let request):
            config = request.config
        case .getConversion(let request):
            config = request.config
        }
        
        return URL(string: config.baseURL) ?? URL(target: self)
    }
    
    var path: String {
        switch self {
        case .getCurrencies(let request):
            return "/api/v1/currencies" + request.urlParametersJoined
        case .getRates(let request):
            return "/api/v1/rates" + request.urlParametersJoined
        case .getConversion(let request):
            return "/api/v1/convert" + request.urlParametersJoined
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCurrencies: return .get
        case .getRates: return .get
        case .getConversion: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
