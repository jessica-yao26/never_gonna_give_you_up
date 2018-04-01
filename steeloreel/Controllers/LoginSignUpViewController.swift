//
//  LoginSignUpViewController.swift
//  steeloreel
//
//  Created by Jessica Yao on 3/27/18.
//  Copyright © 2018 Jessica Yao. All rights reserved.
//

import UIKit

class LoginSignUpViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AppUtility.setupView(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Helpers
    
    // Email validators
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func checkEmailFieldValid() {
        if(emailField.text?.isEmpty)! {
            print("email field is empty")
            self.showToast(message: "Please enter your email")
        }
        else if(!isValidEmail(testStr: emailField.text!)){
            print("email field is invalid")
            self.showToast(message: "Please enter a valid email")
        }
    }
    
    // Database call
    func lookupEmail(email:String){
        var request = URLRequest(url: URL(string:"http://127.0.0.1:8000/users/")!);
        request.httpMethod = "GET";
        let json = ["email":email];
        let jsonData =  try? JSONSerialization.data(withJSONObject: json);
        request.httpBody = jsonData;
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type");
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                // check for a networking error
                print("error=\(String(describing: error))")
                self.showToast(message: "Sorry, something went wrong")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(String(describing: response))")
                
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
        }
        task.resume()
        // parse response logic
    }
    
    // Actions
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        print("inside CBP")
        checkEmailFieldValid()
    }
    
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        print("return pressed")
        checkEmailFieldValid()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
