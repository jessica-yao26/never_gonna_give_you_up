//
//  UserLoginSignUp.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation

struct UserLoginSignUpAPI {
    
    static func checkEmail(email: String) -> Int{
        let URL = StyloURL.checkEmailURL();
        print(URL);
        var request = URLRequest(url: URL);
        request.httpMethod = "GET";
        let json = ["email": email];
        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        request.httpBody = jsonData;
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        var statusCode = 0;
            let task = URLSession.shared.dataTask(with: request) {
                data, response, error in guard let data = data, error == nil else {
                    // check for a networking error
                    print("error=\(String(describing: error))")
                    return;
                }
        
                let httpStatus = response as? HTTPURLResponse
                statusCode = (httpStatus?.statusCode)!
                print(httpStatus)
        
                let responseString = String(data: data, encoding: .utf8)
                print("responseString = \(String(describing: responseString))")
            }
            task.resume()
        
        return statusCode;
    }
}
