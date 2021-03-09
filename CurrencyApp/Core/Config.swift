//
//  Config.swift
//  CurrencyApp
//
//  Created by Khwan Siricharoenporn on 9/3/2564 BE.
//

import Foundation

fileprivate let kBaseURLKey: String = "BASE_URL"
fileprivate let kURLTokenAPIKey: String = "URL_TOKEN_API"

struct Config {
    static var `default`: Config = Config()
    
    private(set) var baseURL: String
    private(set) var apiToken: String
    
    init(type: ConfigType = .default) {
        switch type {
        case .default:
            let plist = Bundle.getPlist(forResource: "Config")
            
            baseURL = plist?[kBaseURLKey] as? String ?? ""
            apiToken = plist?[kURLTokenAPIKey] as? String ?? ""
            
        case .customize(let baseURL, let apiToken):
            self.baseURL = baseURL
            self.apiToken = apiToken
        }
    }
}

//MARK: ConfigType
extension Config {
    enum ConfigType {
        case `default`
        case customize(baseURL: String, apiToken: String)
    }
}
