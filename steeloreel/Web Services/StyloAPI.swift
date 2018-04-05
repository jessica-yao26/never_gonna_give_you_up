//
//  StyloAPI.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation

enum Method: String {
    case checkUserEmailExists = "/user-lookup-email"
}

struct StyloAPI {
    
    static let scheme = "http"
    static let baseURL = "127.0.0.1"
    static let port = 8000
    
    private static func styloURL(method: Method, parameters: [String:String]?) -> URL {
        var components = URLComponents()
        components.scheme = scheme;
        components.host = baseURL;
        components.port = port;
        components.path = method.rawValue;
        var queryItems = [URLQueryItem]()
        let baseParams = [
            "format" : "json"
        ]
        
        for (key, value) in baseParams {
            let item = URLQueryItem(name: key, value: value)
            queryItems.append(item)
        }
        
        if let additionalParams = parameters{
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    static var checkUserEmailExistsURL: URL {
        return styloURL(method: .checkUserEmailExists, parameters: ["email" : "email"])
    }

}
