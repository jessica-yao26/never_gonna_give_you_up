//
//  StyloAPI.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation

enum Method: String {
    case checkUserEmailExists = "/user-lookup-email/"
    case checkUsernameExists = "/user-lookup-username/"
    case createNewUser = "/users/"
    case loginUser = "/login/"
}

struct StyloURL {
    
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
//        let baseParams = [
//            //"format" : "json"
//        ]
//
//        for (key, value) in baseParams {
//            let item = URLQueryItem(name: key, value: value)
//            queryItems.append(item)
//        }
//
        if let additionalParams = parameters {
            for (key, value) in additionalParams {
                let item = URLQueryItem(name: key, value: value)
                queryItems.append(item)
            }
        }
        components.queryItems = queryItems
        return components.url!
    }
    
    static func checkEmailURL(email: String) -> URL {
        return styloURL(method: .checkUserEmailExists, parameters: ["email": email])
    }
    
    static func checkUsernameURL(username: String) -> URL {
        return styloURL(method: .checkUsernameExists, parameters: ["username": username])
    }
    
    static func createNewUser() -> URL {
        return styloURL(method: .createNewUser, parameters: [:])
    }
    
    static func loginUser(username: String, password: String) -> URL {
        return styloURL(method: .loginUser, parameters: ["username": username, "password": password])
    }
}
