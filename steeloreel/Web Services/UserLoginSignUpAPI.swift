//
//  UserLoginSignUp.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation
// APIs contained within the UserLoginSignUp flow
struct UserLoginSignUpAPI {
    
    static func checkEmail(email: String, completion : @escaping (Int) -> Void) {
        let URL = StyloURL.checkEmailURL(email: email);
        var request = URLRequest(url: URL);
        request.httpMethod = "GET";
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        print(request)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in guard error == nil else {
                completion(-1)
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                completion(httpStatus.statusCode)
            }
            return
        })
        task.resume()
    }
    
    static func checkUsername(username: String, completion : @escaping (Int) -> Void) {
        let URL = StyloURL.checkUsernameURL(username: username);
        var request = URLRequest(url: URL);
        request.httpMethod = "GET";
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        print(request)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in guard error == nil else {
                completion(-1)
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                completion(httpStatus.statusCode)
            }
            return
        })
        task.resume()
    }
    
    static func createNewUser(email: String, username: String, password: String, first_name: String, last_name: String, completion : @escaping (Int) -> Void) {
        let URL = StyloURL.createNewUser();
        var request = URLRequest(url: URL);
        request.httpMethod = "POST";
        let json = ["email": email, "username": username, "password": password, "first_name": first_name, "last_name": last_name];
        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        request.httpBody = jsonData;
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        print(request)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in guard error == nil else {
                completion(-1)
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                completion(httpStatus.statusCode)
            }
            return
        })
        task.resume()
    }
    
    static func loginUser(username: String, password: String, completion : @escaping (Int) -> Void) {
        let URL = StyloURL.loginUser(username: username, password: password);
        var request = URLRequest(url: URL);
        request.httpMethod = "POST";
        let json = ["username": username, "password": password];
        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        request.httpBody = jsonData;
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        print(request)
        let task = URLSession.shared.dataTask(with: request, completionHandler: {
            data, response, error in guard error == nil else {
                completion(-1)
                return
            }
            if let httpStatus = response as? HTTPURLResponse {
                completion(httpStatus.statusCode)
            }
            return
        })
        task.resume()
    }
}
