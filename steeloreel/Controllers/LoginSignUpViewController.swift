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
        //DispatchQueue.main.async() {
            AppUtility.setupLandingView(view: self.view)
        //}
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
    
    func isEmailFieldValid() -> Bool {
        if(emailField.text?.isEmpty)! {
            print("email field is empty")
            self.showToast(message: "Please enter your email")
            return false;
        }
        if(!isValidEmail(testStr: emailField.text!)){
            print("email field is invalid")
            self.showToast(message: "Please enter a valid email")
            return false;
        }
        return true;
    }
    
    // Actions
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        print("inside CBP")
        checkEmail(email: self.emailField.text!);
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        print("return pressed")
        checkEmail(email: self.emailField.text!);
    }
    
    func checkEmail(email: String) {
        emailField.resignFirstResponder()

        if(isEmailFieldValid()) {
            let statusCode = UserLoginSignUpAPI.checkEmail(email: self.emailField.text!)
            print("status code:")
            print(statusCode)
            
            if(statusCode == 404) {
                self.showToast(message: "new email")
            }
            else if(statusCode == 200) {
                self.showToast(message: "old email")
            }
            else {
                self.showToast(message: "Sorry, something went wrong")
            }
        }
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
