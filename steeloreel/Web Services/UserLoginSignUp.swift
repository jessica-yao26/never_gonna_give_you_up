//
//  UserLoginSignUp.swift
//  steeloreel
//
//  Created by Jessica Yao on 4/3/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import Foundation

//class UserLoginSignUp {
//    private let session: URLSession = {
//        let config = URLSessionConfiguration.default
//        return URLSession(configuration: config)
//    }()
//    func isEmailAlreadyRegistered(email:String) -> Bool{
//        let URL = StyloAPI.checkUserEmailExistsURL;
//        print(URL)
////        var request = URLRequest(url: URL);
////        let task = session.dataTask(with: request)
////        request.httpMethod = "GET";
////        let json = ["email":email];
////        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
////        request.httpBody = jsonData;
////        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
////        var emailFound = false;
//        //    let task = URLSession.shared.dataTask(with: request) { data, response, error in
//        //        guard let data = data, error == nil else {
//        //            // check for a networking error
//        //            print("error=\(String(describing: error))")
//        //            return
//        //        }
//        //
//        //        let httpStatus = response as? HTTPURLResponse
//        //        if(httpStatus?.statusCode == 200){
//        //            emailFound = true;
//        //        }
//        //        if(httpStatus?.statusCode == 404){
//        //            emailFound = false;
//        //        }
//        //
//        //        let responseString = String(data: data, encoding: .utf8)
//        //        print("responseString = \(String(describing: responseString))")
//        //    }
//        //    task.resume()
////        return emailFound;
//        return false;
//    }
//}
struct UserLoginSignUp{
    static func isEmailAlreadyRegistered(email:String) -> Bool{
        let URL = StyloAPI.checkUserEmailExistsURL;
        print(URL)
        //        var request = URLRequest(url: URL);
        //        let task = session.dataTask(with: request)
        //        request.httpMethod = "GET";
        //        let json = ["email":email];
        //        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        //        request.httpBody = jsonData;
        //        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        //        var emailFound = false;
        //    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        //        guard let data = data, error == nil else {
        //            // check for a networking error
        //            print("error=\(String(describing: error))")
        //            return
        //        }
        //
        //        let httpStatus = response as? HTTPURLResponse
        //        if(httpStatus?.statusCode == 200){
        //            emailFound = true;
        //        }
        //        if(httpStatus?.statusCode == 404){
        //            emailFound = false;
        //        }
        //
        //        let responseString = String(data: data, encoding: .utf8)
        //        print("responseString = \(String(describing: responseString))")
        //    }
        //    task.resume()
        //        return emailFound;
        return false;
    }
}
