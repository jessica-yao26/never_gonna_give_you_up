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
        AppUtility.setupLandingView(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Helper functions
    
    // Email validators
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
    }
    
    func isEmailFieldValid() -> Bool {
        if(emailField.text?.isEmpty)! {
            self.showToast(message: "Please enter your email")
            return false;
        }
        if(!isValidEmail(testStr: emailField.text!)){
            self.showToast(message: "Please enter a valid email")
            return false;
        }
        return true;
    }
    // Email checker
    func checkEmail(email: String) {
        emailField.resignFirstResponder()

        if(isEmailFieldValid()) {

            UserLoginSignUpAPI.checkEmail(email: email, completion: { response in
                let statusCode = response
                DispatchQueue.main.async {
                    if(statusCode == 404) {
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "SetPasswordViewController") as! SetPasswordViewController
                        self.present(nextViewController, animated: true, completion: nil)
                    }
                    else if(statusCode == 200) {
                        let nextViewController = self.storyboard?.instantiateViewController(withIdentifier: "EnterPasswordViewController") as! EnterPasswordViewController
                        self.present(nextViewController, animated: true, completion: nil)
                    }
                    else {
                        self.showToast(message: "Sorry, something went wrong")
                    }
                }
            })
        }
    }
    
    // Actions
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        checkEmail(email: self.emailField.text!);
    }
    
    @IBAction func returnKeyPressed(_ sender: Any) {
        checkEmail(email: self.emailField.text!);
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
