//
//  UserLoginSignUp.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation

struct UserLoginSignUpAPI {
    
    static func checkEmail(email: String, completion : @escaping (Int) -> Void) {
        let URL = StyloURL.checkEmailURL();
        var request = URLRequest(url: URL);
        request.httpMethod = "GET";
        let json = ["email": email];
        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        request.httpBody = jsonData;
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
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
